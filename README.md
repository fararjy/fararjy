# فرارجي — نظام v2 (Cloudflare Workers + D1)

## الهيكل
- `schema.sql` — مخطط قاعدة البيانات D1 (يتشغّل مرة واحدة)
- `src/index.js` — كود الـ Worker (نفس بروتوكول API القديم)
- `seed.sql` — بيانات الترحيل من Google Sheets (بيتولد من التصدير)

## خريطة الهجرة
- ✅ المرحلة أ: القراءة (login, search, lookup, menu, config, history)
- ⬜ المرحلة أ2: ترحيل البيانات + التحقق من المطابقة
- ⬜ المرحلة أ3: الكتابة (sale, redeem, bonus) + تحويل المواقع
- ⬜ المرحلة ب: الحسابات + الاستيراد + بوت الواتساب
- ⬜ المرحلة ج: الكاشير

## الإعداد (Dashboard بدون CLI)
1. D1: أنشئ قاعدة باسم `fararjy-db` وشغّل `schema.sql` في Console
2. Worker: Workers & Pages ← Create ← Worker باسم `fararjy-api` ← الصق `src/index.js`
3. الربط: إعدادات الـ Worker ← Bindings ← Add ← D1 Database ← Variable name: `DB` ← اختر `fararjy-db`
4. اختبار: افتح رابط الـ Worker — المفروض يرد "فرارجي API v2 شغال ✅"
