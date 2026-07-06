-- ======================================================
-- فرارجي — مخطط قاعدة البيانات D1 (المرحلة أ)
-- شغّل الملف ده مرة واحدة في D1 Console
-- ======================================================

CREATE TABLE IF NOT EXISTS customers (
  phone TEXT PRIMARY KEY,              -- 01xxxxxxxxx
  name TEXT DEFAULT '',
  purchases REAL DEFAULT 0,            -- إجمالي المشتريات
  lifetime_points INTEGER DEFAULT 0,   -- المكتسب مدى الحياة
  current_points INTEGER DEFAULT 0,    -- الرصيد الحالي
  redeemed_points INTEGER DEFAULT 0,
  expired_points INTEGER DEFAULT 0,
  tier TEXT DEFAULT 'برونزي',
  registered_at TEXT,                  -- ISO datetime
  last_activity TEXT,
  notes TEXT DEFAULT ''
);

CREATE TABLE IF NOT EXISTS transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  created_at TEXT NOT NULL,
  phone TEXT DEFAULT '',               -- فاضي = فاتورة بدون عميل
  amount REAL NOT NULL,
  offer_label TEXT DEFAULT 'بدون عرض', -- أو "استيراد:M10213 | بدون عرض"
  multiplier REAL DEFAULT 1,
  points INTEGER DEFAULT 0,
  invoice_id TEXT DEFAULT '',          -- رقم فاتورة السيستم للحماية من التكرار
  by_user TEXT DEFAULT ''
);
CREATE INDEX IF NOT EXISTS idx_txn_phone ON transactions(phone);
CREATE INDEX IF NOT EXISTS idx_txn_invoice ON transactions(invoice_id);
CREATE INDEX IF NOT EXISTS idx_txn_date ON transactions(created_at);

CREATE TABLE IF NOT EXISTS redemptions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  created_at TEXT NOT NULL,
  phone TEXT NOT NULL,
  points INTEGER NOT NULL,
  reward TEXT DEFAULT '',
  by_user TEXT DEFAULT ''
);
CREATE INDEX IF NOT EXISTS idx_red_phone ON redemptions(phone);

CREATE TABLE IF NOT EXISTS offers (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  multiplier REAL DEFAULT 1,
  active INTEGER DEFAULT 1
);

CREATE TABLE IF NOT EXISTS rewards (
  code TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  type TEXT DEFAULT 'استبدال',        -- استبدال / امتياز
  points INTEGER NOT NULL,
  active INTEGER DEFAULT 1
);

CREATE TABLE IF NOT EXISTS users (
  username TEXT PRIMARY KEY,
  pin TEXT NOT NULL,
  role TEXT DEFAULT 'موظف',            -- أدمن / موظف
  perm_sale INTEGER DEFAULT 1,
  perm_redeem INTEGER DEFAULT 1,
  perm_add_customer INTEGER DEFAULT 1,
  perm_reports INTEGER DEFAULT 0,
  perm_bonus INTEGER DEFAULT 0,
  perm_accounting INTEGER DEFAULT 0,
  active INTEGER DEFAULT 1
);

CREATE TABLE IF NOT EXISTS sessions (
  token TEXT PRIMARY KEY,
  username TEXT NOT NULL,
  expires_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS settings (
  key TEXT PRIMARY KEY,
  value TEXT
);

CREATE TABLE IF NOT EXISTS mapping (
  system_name TEXT PRIMARY KEY,        -- اسم العميل في EzeeManager
  phone TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS menu (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  section TEXT NOT NULL,
  name TEXT NOT NULL,
  unit TEXT DEFAULT 'كيلو',            -- كيلو / فرخة / جوز
  prep TEXT DEFAULT '',                -- "كاملة|مقطعة 4|مقطعة 8"
  active INTEGER DEFAULT 1,
  sort_order INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS log (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  created_at TEXT NOT NULL,
  username TEXT,
  action TEXT,
  details TEXT
);

-- الإعدادات الافتراضية (نفس قيم النظام الحالي)
INSERT OR IGNORE INTO settings (key, value) VALUES
  ('egp_per_point', '10'),
  ('expiry_days', '180'),
  ('tier_silver', '500'),
  ('tier_gold', '2000'),
  ('tier_vip', '5000'),
  ('store_name', 'فرارجي');
