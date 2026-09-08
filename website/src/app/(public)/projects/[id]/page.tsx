"use client";

import React, { useState, useEffect } from "react";
import { useParams, notFound } from "next/navigation";
import { Project } from "@/types/api";
import { SWAPNOJATRI_PROJECTS, FALLBACK_LANDVEST_100, findProject } from "@/lib/api/projects";
import ProjectDetailView from "@/components/project/ProjectDetailView";

export default function DynamicProjectPage() {
  const params = useParams();
  const idOrCode = (params?.id as string) || "LV100";

  const [project, setProject] = useState<Project | null>(() => {
    return findProject(idOrCode) || null;
  });

  const [loading, setLoading] = useState(!project);

  useEffect(() => {
    async function fetchProject() {
      try {
        const res = await fetch(`/api/projects/${idOrCode}`);
        const json = await res.json();
        if (json.success && json.data) {
          setProject(json.data);
        } else {
          const localMatch = findProject(idOrCode);
          if (localMatch) {
            setProject(localMatch);
          } else if (!project) {
            setProject(FALLBACK_LANDVEST_100);
          }
        }
      } catch (err) {
        console.error("Error fetching project:", err);
        const localMatch = findProject(idOrCode);
        if (localMatch) {
          setProject(localMatch);
        } else if (!project) {
          setProject(FALLBACK_LANDVEST_100);
        }
      } finally {
        setLoading(false);
      }
    }

    fetchProject();
  }, [idOrCode]);

  if (loading && !project) {
    return (
      <div className="min-h-[500px] flex items-center justify-center">
        <div className="flex flex-col items-center gap-3">
          <div className="w-8 h-8 rounded-full border-2 border-[#0066FF] border-t-transparent animate-spin" />
          <span className="text-xs text-slate-500 font-medium">Loading project details...</span>
        </div>
      </div>
    );
  }

  if (!project) {
    return notFound();
  }

  return <ProjectDetailView project={project} />;
}
