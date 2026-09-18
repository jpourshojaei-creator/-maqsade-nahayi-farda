import type { Config } from "tailwindcss";
const config: Config = {
  content: ["./app/**/*.{ts,tsx}", "./components/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        navy: "#0B1F3A",
        royal: "#2563EB",
        gold: "#D4A72C",
        ink: "#172033",
        muted: "#64748B"
      },
      fontFamily: { sans: ["Vazirmatn", "ui-sans-serif", "system-ui"] },
      boxShadow: { premium: "0 18px 55px rgba(11,31,58,.10)" }
    }
  },
  plugins: []
};
export default config;