import Image from "next/image";
import Link from "next/link";
export function Header(){
 return <header className="sticky top-0 z-50 border-b bg-[#0B1F3A]/95 text-white backdrop-blur">
  <div className="container-x flex h-20 items-center justify-between gap-5">
   <Link href="/" className="flex items-center gap-3 font-extrabold"><Image src="/logo.jpeg" width={54} height={54} className="rounded-full border border-gold object-cover" alt="لوگوی مقصد نهایی فردا"/><span>مقصد نهایی فردا</span></Link>
   <nav className="hidden items-center gap-6 text-sm lg:flex">
    {["درباره ما","خدمات","دانشگاه‌ها","کشورها","رشته‌ها","مقالات","پذیرش‌ها","تماس با ما"].map((x,i)=><Link key={x} href={["/about","/services","/universities","/countries/china","/fields","/blog","/admissions","/contact"][i]} className="transition hover:text-gold">{x}</Link>)}
   </nav>
   <Link href="/consultation" className="rounded-xl bg-royal px-5 py-2.5 text-sm font-bold shadow-lg shadow-royal/20 hover:bg-blue-500">دریافت مشاوره</Link>
  </div>
 </header>
}