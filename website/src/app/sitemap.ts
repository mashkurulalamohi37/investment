import { MetadataRoute } from "next";

export default function sitemap(): MetadataRoute.Sitemap {
  const baseUrl = "https://swapnojatri.com";

  const staticRoutes = [
    "",
    "/projects",
    "/projects/landvest-100",
    "/how-it-works",
    "/documents",
    "/about",
    "/faq",
    "/contact",
  ];

  return staticRoutes.map((route) => ({
    url: `${baseUrl}${route}`,
    lastModified: new Date().toISOString(),
    changeFrequency: route === "" || route.startsWith("/projects") ? "daily" : "weekly",
    priority: route === "" ? 1.0 : route.startsWith("/projects") ? 0.9 : 0.8,
  }));
}
