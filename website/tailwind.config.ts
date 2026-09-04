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
        // Royal Cobalt Blue System — matches Flutter app's AppPalette.royalBlue
        brand: {
          darkest: "#040D1A",       // Deep midnight canvas (Flutter: 0xFF0A1118)
          primary: "#0A2540",       // Deep Navy (Flutter: pineDeep 0xFF0A2540)
          forest: "#0052CC",        // Deep brand blue (Flutter: royalBlueDark.pineDeep)
          emerald: "#0066FF",       // Vibrant Royal Cobalt Blue (Flutter: pine 0xFF0066FF)
          light: "#EBF3FF",         // Soft Royal Blue Chip Tint (Flutter: pineTint 0xFFEBF3FF)
        },
        // Cyan accent — replaces gold, matches Flutter's brass/skyCyan
        cyan: {
          DEFAULT: "#00B4D8",       // Sky Cyan (Flutter: brass 0xFF00B4D8)
          light: "#48CAE4",         // Bright Cyan (Flutter: brassLight 0xFF48CAE4)
          dark: "#0096B7",
          tint: "#E0F7FC",
        },
        // Accent gold kept for CTAs only (profit/action visual)
        gold: {
          DEFAULT: "#2979FF",       // Remapped to electric blue accent for CTA chips
          light: "#5393FF",
          dark: "#0052CC",
          tint: "#EBF3FF",
        },
        // Profit green stays (Flutter: jade 0xFF00C853)
        jade: {
          DEFAULT: "#00C853",
          dark: "#00A844",
          light: "#CCFFE6",
        },
        // Amber warning (Flutter: amberInk 0xFFF59E0B)
        amber: {
          DEFAULT: "#F59E0B",
          light: "#FDE68A",
        },
        // Canvas / neutral (matches Flutter: canvas, surface, surfaceSunken)
        canvas: {
          light: "#F8FAFC",         // Flutter: royalBlueLight.canvas 0xFFF8FAFC
          card: "#FFFFFF",          // Flutter: royalBlueLight.surface 0xFFFFFFFF
          border: "#E2E8F0",        // Flutter: royalBlueLight.rule 0xFFE2E8F0
          dark: "#0A1118",          // Flutter: royalBlueDark.canvas 0xFF0A1118
          darkCard: "#131D28",      // Flutter: royalBlueDark.surface 0xFF131D28
          darkBorder: "#1E2D3D",    // Flutter: royalBlueDark.rule 0xFF1E2D3D
        },
      },
      fontFamily: {
        sans: ["var(--font-hind)", "var(--font-noto-bengali)", "var(--font-jakarta)", "system-ui", "sans-serif"],
        display: ["var(--font-noto-bengali)", "var(--font-jakarta)", "sans-serif"],
        bengali: ["var(--font-hind)", "var(--font-noto-bengali)", "sans-serif"],
      },
      boxShadow: {
        card: "0 4px 20px -2px rgba(10, 37, 64, 0.06)",
        cardHover: "0 12px 30px -4px rgba(10, 37, 64, 0.14)",
        blueGlow: "0 0 30px rgba(0, 102, 255, 0.25)",
        cyanGlow: "0 0 25px rgba(0, 180, 216, 0.25)",
        profitGlow: "0 0 25px rgba(0, 200, 83, 0.2)",
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
