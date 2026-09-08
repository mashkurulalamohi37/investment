"use client";

import { useState, useEffect, useCallback } from "react";
import { MasterCmsState, DEFAULT_MASTER_CMS } from "@/types/cms";

const STORAGE_KEY = "swapnojatri_master_cms";
const CMS_EVENT_KEY = "swapnojatri_cms_updated";

export function useCms() {
  const [cms, setCms] = useState<MasterCmsState>(DEFAULT_MASTER_CMS);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Sync state from server or local cache
  const loadCms = useCallback(async () => {
    // 1. Try local storage first for instantaneous hydration
    try {
      if (typeof window !== "undefined") {
        const cached = localStorage.getItem(STORAGE_KEY);
        if (cached) {
          const parsed = JSON.parse(cached);
          if (parsed && parsed.global && parsed.home) {
            setCms((prev) => ({
              ...prev,
              ...parsed,
              global: { ...prev.global, ...(parsed.global || {}) },
              home: { ...prev.home, ...(parsed.home || {}) },
              about: { ...prev.about, ...(parsed.about || {}) },
              howItWorks: { ...prev.howItWorks, ...(parsed.howItWorks || {}) },
              faq: { ...prev.faq, ...(parsed.faq || {}) },
              documents: { ...prev.documents, ...(parsed.documents || {}) },
              contact: { ...prev.contact, ...(parsed.contact || {}) },
            }));
          }
        }
      }
    } catch (e) {
      console.warn("Could not read local CMS cache:", e);
    }

    // 2. Fetch fresh from API
    try {
      const res = await fetch("/api/cms", { cache: "no-store" });
      const json = await res.json();
      if (json.success && json.data) {
        setCms(json.data);
        if (typeof window !== "undefined") {
          localStorage.setItem(STORAGE_KEY, JSON.stringify(json.data));
        }
      }
    } catch (err) {
      console.warn("Failed to fetch fresh CMS from API, using fallback cache:", err);
      setError(String(err));
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    loadCms();

    // Listen to local update events across components or tabs
    const handleCmsUpdate = (e: CustomEvent | StorageEvent) => {
      if ("detail" in e && e.detail) {
        setCms(e.detail);
      } else {
        loadCms();
      }
    };

    if (typeof window !== "undefined") {
      window.addEventListener(CMS_EVENT_KEY as any, handleCmsUpdate);
      window.addEventListener("storage", (e) => {
        if (e.key === STORAGE_KEY) loadCms();
      });
    }

    return () => {
      if (typeof window !== "undefined") {
        window.removeEventListener(CMS_EVENT_KEY as any, handleCmsUpdate);
      }
    };
  }, [loadCms]);

  // Update a single section
  const updateSection = async <K extends keyof MasterCmsState>(
    section: K,
    data: MasterCmsState[K]
  ): Promise<boolean> => {
    try {
      const updatedState = {
        ...cms,
        [section]: data,
        updatedAt: new Date().toISOString(),
      };

      // Optimistically update
      setCms(updatedState);
      if (typeof window !== "undefined") {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(updatedState));
        window.dispatchEvent(new CustomEvent(CMS_EVENT_KEY, { detail: updatedState }));
      }

      const res = await fetch("/api/cms", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ section, data }),
      });
      const json = await res.json();
      return !!json.success;
    } catch (err) {
      console.error(`Failed to update CMS section '${String(section)}':`, err);
      return false;
    }
  };

  // Save the entire master CMS state
  const saveMasterCms = async (newMasterCms: MasterCmsState): Promise<boolean> => {
    try {
      const stateToSave = {
        ...newMasterCms,
        updatedAt: new Date().toISOString(),
      };

      // Optimistic update
      setCms(stateToSave);
      if (typeof window !== "undefined") {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(stateToSave));
        window.dispatchEvent(new CustomEvent(CMS_EVENT_KEY, { detail: stateToSave }));
      }

      const res = await fetch("/api/cms", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ data: stateToSave }),
      });
      const json = await res.json();
      return !!json.success;
    } catch (err) {
      console.error("Failed to save full Master CMS:", err);
      return false;
    }
  };

  // Factory reset
  const resetToDefaults = async (): Promise<boolean> => {
    try {
      const res = await fetch("/api/cms", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ action: "reset" }),
      });
      const json = await res.json();
      if (json.success && json.data) {
        setCms(json.data);
        if (typeof window !== "undefined") {
          localStorage.setItem(STORAGE_KEY, JSON.stringify(json.data));
          window.dispatchEvent(new CustomEvent(CMS_EVENT_KEY, { detail: json.data }));
        }
        return true;
      }
      return false;
    } catch (err) {
      console.error("Failed to reset CMS:", err);
      return false;
    }
  };

  return {
    cms,
    global: cms.global || DEFAULT_MASTER_CMS.global,
    home: cms.home || DEFAULT_MASTER_CMS.home,
    about: cms.about || DEFAULT_MASTER_CMS.about,
    howItWorks: cms.howItWorks || DEFAULT_MASTER_CMS.howItWorks,
    faq: cms.faq || DEFAULT_MASTER_CMS.faq,
    documents: cms.documents || DEFAULT_MASTER_CMS.documents,
    contact: cms.contact || DEFAULT_MASTER_CMS.contact,
    loading,
    error,
    reload: loadCms,
    updateSection,
    saveMasterCms,
    resetToDefaults,
  };
}
