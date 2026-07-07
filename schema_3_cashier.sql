ALTER TABLE menu ADD COLUMN price REAL DEFAULT 0;
CREATE TABLE IF NOT EXISTS invoices (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  invoice_no TEXT UNIQUE,
  created_at TEXT NOT NULL,
  phone TEXT DEFAULT '',
  customer_name TEXT DEFAULT '',
  address TEXT DEFAULT '',
  driver TEXT DEFAULT '',
  subtotal REAL DEFAULT 0,
  discount REAL DEFAULT 0,
  delivery_fee REAL DEFAULT 0,
  total REAL DEFAULT 0,
  points INTEGER DEFAULT 0,
  by_user TEXT DEFAULT ''
);
CREATE INDEX IF NOT EXISTS idx_inv_phone ON invoices(phone);
CREATE INDEX IF NOT EXISTS idx_inv_date ON invoices(created_at);
CREATE TABLE IF NOT EXISTS invoice_items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  invoice_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  unit TEXT DEFAULT 'كيلو',
  qty REAL NOT NULL,
  price REAL NOT NULL,
  line_total REAL NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_items_inv ON invoice_items(invoice_id);
