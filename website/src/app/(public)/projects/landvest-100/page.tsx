"use client";

import React, { useState, useEffect } from "react";
import { FALLBACK_LANDVEST_100 } from "@/lib/api/projects";
import { Project } from "@/types/api";
import ProjectDetailView from "@/components/project/ProjectDetailView";

export default function LandVest100Page() {
  const [project, setProject] = useState<Project>(FALLBACK_LANDVEST_100);

  useEffect(() => {
    async function loadLiveProject() {
      try {
        const res = await fetch("/api/projects/LV100");
        const json = await res.json();
        if (json.success && json.data) {
          setProject(json.data);
        }
      } catch (e) {
        // Keep fallback
      }
    }
    loadLiveProject();
  }, []);

  return <ProjectDetailView project={project} />;
}
