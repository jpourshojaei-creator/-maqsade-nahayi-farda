# مقصد نهایی فردا — Production-ready foundation

این پروژه یک پایه حرفه‌ای Next.js + TypeScript + Tailwind + Supabase برای مؤسسه «مقصد نهایی فردا» است.

## اجرا
1. Node.js نصب باشد.
2. `npm install`
3. `.env.example` را به `.env.local` تبدیل و مقادیر Supabase را وارد کنید.
4. در Supabase فایل `supabase/schema.sql` را اجرا کنید.
5. `npm run dev`
6. برای Production: `npm run build && npm start`

## معماری
- Next.js App Router + TypeScript
- RTL + Vazirmatn
- Tailwind CSS + shadcn-style UI primitives
- Supabase Auth / PostgreSQL / Storage / RLS
- مسیرهای Public، Admin و Student Dashboard
- Schema کامل برای students, applications, documents, admissions, universities, programs, fields, blog, FAQ, testimonials, media و notifications
- فایل‌های شخصی در bucket خصوصی و با Signed URL در معماری نهایی مصرف شوند.
- پذیرش‌های عمومی فقط بعد از Publish/Review ادمین نمایش داده شوند.

## نکته
اتصال فرم مشاوره در این نسخه UI/validation-ready است؛ برای Production کافی است submit آن به API/Server Action متصل شود. اطلاعات واقعی دانشگاه‌ها، شهریه، رتبه، بورسیه و قوانین ویزا عمداً به صورت Demo وارد نشده‌اند و باید از منابع رسمی تأمین شوند.

لوگوی واقعی آپلودشده مؤسسه در `public/logo.jpeg` قرار گرفته است.

## ارتباط مؤسسه
- اسماعیلی: 09176869232
- پورشجاعی: 09330384095
- تلگرام: https://t.me/Maqsadenahayifarda
- واتساپ و اپلیکیشن‌های ایرانی: 09330384095
- اینستاگرام: @Javad_p7

## پذیرش‌های ارائه‌شده
تصاویر موجود در `public/admissions/` از ویدئوی آپلودشده توسط کاربر استخراج شده‌اند و در گالری نمونه پذیرش نمایش داده می‌شوند. پیش از انتشار عمومی Production، مجوز انتشار و حذف/Blur اطلاعات شخصی باید توسط Admin بررسی شود.
