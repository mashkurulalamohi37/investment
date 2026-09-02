import { MetadataRoute } from "next";

export default function robots(): MetadataRoute.Robots {
  return {
    rules: [
      {
        userAgent: "*",
        allow: [
          "/",
          "/projects",
          "/projects/*",
          "/how-it-works",
          "/documents",
          "/about",
          "/faq",
          "/contact",
        ],
        disallow: [
          "/dashboard",
          "/dashboard/*",
          "/admin",
          "/admin/*",
          "/profile",
          "/profile/*",
          "/api/*",
        ],
      },
    ],
    sitemap: "https://swapnojatri.com/sitemap.xml",
  };
}
