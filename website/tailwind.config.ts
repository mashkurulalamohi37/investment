import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        brand: {
          darkest: "#041811",
          primary: "#062319",
          forest: "#0D3B2E",
          emerald: "#145A46",
          light: "#E8F5F1",
        },
        gold: {
          DEFAULT: "#C59B27",
          light: "#DFBA46",
          dark: "#9E7A1C",
          tint: "#FFF9E6",
        },
        jade: {
          DEFAULT: "#10B981",
          dark: "#059669",
          light: "#D1FAE5",
        },
        canvas: {
          light: "#F8FAFC",
          card: "#FFFFFF",
          border: "#E2E8F0",
          dark: "#0B131E",
          darkCard: "#131E2C",
          darkBorder: "#243447",
        },
      },
      fontFamily: {
        sans: ["var(--font-outfit)", "var(--font-hind)", "system-ui", "sans-serif"],
        display: ["var(--font-outfit)", "sans-serif"],
        bengali: ["var(--font-hind)", "sans-serif"],
      },
      boxShadow: {
        card: "0 4px 20px -2px rgba(15, 43, 72, 0.06)",
        cardHover: "0 12px 30px -4px rgba(15, 43, 72, 0.12)",
        goldGlow: "0 0 25px rgba(197, 155, 39, 0.25)",
        emeraldGlow: "0 0 25px rgba(16, 185, 129, 0.2)",
      },
      borderRadius: {
        card: "16px",
        chip: "100px",
      },
    },
  },
  plugins: [],
};

export default config;
