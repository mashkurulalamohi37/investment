"use client";

import React, { createContext, useContext, useEffect, useState } from "react";
import { User } from "@/types/api";

interface AuthContextType {
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
  isLoading: boolean;
  isBangla: boolean;
  toggleLanguage: () => void;
  login: (token: string, user: User) => void;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [token, setToken] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [isBangla, setIsBangla] = useState(false);

  useEffect(() => {
    try {
      const storedToken = localStorage.getItem("swapnojatri_access_token");
      const storedUser = localStorage.getItem("swapnojatri_user");
      const storedLang = localStorage.getItem("swapnojatri_lang");

      if (storedToken && storedUser) {
        setToken(storedToken);
        setUser(JSON.parse(storedUser));
      }
      if (storedLang === "bn") {
        setIsBangla(true);
      }
    } catch (e) {
      console.error("Failed to load stored auth state", e);
    } finally {
      setIsLoading(false);
    }
  }, []);

  const toggleLanguage = () => {
    setIsBangla((prev) => {
      const next = !prev;
      localStorage.setItem("swapnojatri_lang", next ? "bn" : "en");
      return next;
    });
  };

  const login = (newToken: string, newUser: User) => {
    setToken(newToken);
    setUser(newUser);
    localStorage.setItem("swapnojatri_access_token", newToken);
    localStorage.setItem("swapnojatri_user", JSON.stringify(newUser));
  };

  const logout = () => {
    setToken(null);
    setUser(null);
    localStorage.removeItem("swapnojatri_access_token");
    localStorage.removeItem("swapnojatri_user");
    window.location.href = "/";
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        token,
        isAuthenticated: !!token && !!user,
        isLoading,
        isBangla,
        toggleLanguage,
        login,
        logout,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider");
  }
  return context;
};
