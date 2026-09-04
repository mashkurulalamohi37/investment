"use client";

import React, { createContext, useContext, useEffect, useState } from "react";

type Theme = "light" | "dark";

interface AdminThemeContextType {
  theme: Theme;
  toggleTheme: () => void;
  isDark: boolean;
}

const AdminThemeContext = createContext<AdminThemeContextType>({
  theme: "light",
  toggleTheme: () => {},
  isDark: false,
});

export function AdminThemeProvider({ children }: { children: React.ReactNode }) {
  const [theme, setTheme] = useState<Theme>("light");
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
    const saved = localStorage.getItem("swapnojatri_admin_theme") as Theme | null;
    if (saved === "dark" || saved === "light") {
      setTheme(saved);
    }
  }, []);

  const toggleTheme = () => {
    const next = theme === "light" ? "dark" : "light";
    setTheme(next);
    localStorage.setItem("swapnojatri_admin_theme", next);
  };

  const isDark = mounted && theme === "dark";

  return (
    <AdminThemeContext.Provider value={{ theme, toggleTheme, isDark }}>
      <div className={isDark ? "dark" : ""}>
        {children}
      </div>
    </AdminThemeContext.Provider>
  );
}

export function useAdminTheme() {
  return useContext(AdminThemeContext);
}
