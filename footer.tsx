import Link from "next/link";
export function Footer(){return <footer className="bg-navy text-white"><div className="container-x grid gap-10 py-14 md:grid-cols-4">
 <div><h3 className="text-xl font-extrabold">مقصد نهایی فردا</h3><p className="mt-3 text-sm leading-8 text-slate-300">همراه شما در مسیر تحصیل در چین و روسیه.</p></div>
 <div><h4 className="font-bold text-gold">دسترسی سریع</h4><div className="mt-4 grid gap-2 text-sm text-slate-300"><Link href="/about">درباره ما</Link><Link href="/services">خدمات</Link><Link href="/universities">دانشگاه‌ها</Link><Link href="/blog">مقالات</Link></div></div>
 <div><h4 className="font-bold text-gold">مقاصد</h4><div className="mt-4 grid gap-2 text-sm text-slate-300"><Link href="/countries/china">تحصیل در چین</Link><Link href="/countries/russia">تحصیل در روسیه</Link><Link href="/fields">رشته‌ها</Link><Link href="/faq">سوالات متداول</Link></div></div>
 <div><h4 className="font-bold text-gold">ارتباط</h4><div className="mt-4 grid gap-2 text-sm text-slate-300"><a href="tel:09176869232">اسماعیلی: 09176869232</a><a href="tel:09330384095">پورشجاعی: 09330384095</a><a href="https://instagram.com/Javad_p7" target="_blank">@Javad_p7</a>
<a href="https://t.me/Maqsadenahayifarda" target="_blank">کانال تلگرام</a>
<a href="https://wa.me/989330384095" target="_blank">واتساپ: 09330384095</a>
<span>تلگرام و اپلیکیشن‌های ایرانی: 09330384095</span></div></div>
 </div><div className="border-t border-white/10"><div className="container-x flex flex-wrap justify-between gap-3 py-5 text-xs text-slate-400"><span>© 2026 مقصد نهایی فردا. تمامی حقوق محفوظ است.</span><span>امروز تصمیم بگیر، فردای متفاوتت را بساز.</span></div></div></footer>}