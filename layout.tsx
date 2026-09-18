import type { Metadata } from "next";
import "./globals.css";
import { Header } from "@/components/header";
import { Footer } from "@/components/footer";

export const metadata: Metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL || "http://localhost:3000"),
  title: { default: "مقصد نهایی فردا | پذیرش تحصیلی چین و روسیه", template: "%s | مقصد نهایی فردا" },
  description: "مقصد نهایی فردا، همراه شما در مسیر انتخاب دانشگاه، اخذ پذیرش و آغاز تحصیل در چین و روسیه.",
  openGraph: { title: "مقصد نهایی فردا", description: "تحصیل در چین و روسیه با مشاوره و همراهی مرحله‌به‌مرحله.", type: "website" }
};

export default function RootLayout({children}:{children:React.ReactNode}) {
  return <html lang="fa" dir="rtl"><body><Header/><main>{children}</main><Footer/></body></html>
}