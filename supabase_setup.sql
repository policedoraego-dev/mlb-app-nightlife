-- ============================================================
--  Night Phrase Book — Supabase セットアップ SQL
--  Supabase ダッシュボード > SQL Editor に貼り付けて実行
-- ============================================================

-- ── フレーズテーブル ──────────────────────────────────────
CREATE TABLE IF NOT EXISTS phrases_nightlife (
  id          bigint        PRIMARY KEY,         -- Date.now() の値をそのまま使用
  phrase      text          NOT NULL DEFAULT '',
  ipa         text          NOT NULL DEFAULT '',
  reading     text          NOT NULL DEFAULT '',
  meaning     text          NOT NULL DEFAULT '',
  category    text          NOT NULL DEFAULT 'bar',
  example     text          NOT NULL DEFAULT '',
  tags        jsonb         NOT NULL DEFAULT '[]',
  starred     boolean       NOT NULL DEFAULT false,
  words       jsonb         NOT NULL DEFAULT '[]',
  phrase_es   text          NOT NULL DEFAULT '',
  ipa_es      text          NOT NULL DEFAULT '',
  words_es    jsonb         NOT NULL DEFAULT '[]',
  nuance      text          NOT NULL DEFAULT '',
  created_at  timestamptz   NOT NULL DEFAULT now()
);

-- ── カテゴリーテーブル ────────────────────────────────────
CREATE TABLE IF NOT EXISTS categories_nightlife (
  key         text          PRIMARY KEY,
  label       text          NOT NULL,
  palette_idx integer       NOT NULL DEFAULT 0,
  built_in    boolean       NOT NULL DEFAULT false,
  sort_order  integer       NOT NULL DEFAULT 100
);

-- ── Row Level Security（認証なしで読み書き可）────────────
ALTER TABLE phrases_nightlife    ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories_nightlife ENABLE ROW LEVEL SECURITY;

-- 既存ポリシーがある場合は一度削除してから再作成
DROP POLICY IF EXISTS "Allow all phrases_nightlife"    ON phrases_nightlife;
DROP POLICY IF EXISTS "Allow all categories_nightlife" ON categories_nightlife;

CREATE POLICY "Allow all phrases_nightlife"
  ON phrases_nightlife FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all categories_nightlife"
  ON categories_nightlife FOR ALL USING (true) WITH CHECK (true);

-- ── 確認クエリ（実行後にテーブルが存在するか確認）────────
SELECT 'phrases_nightlife'    AS table_name, count(*) AS rows FROM phrases_nightlife
UNION ALL
SELECT 'categories_nightlife' AS table_name, count(*) AS rows FROM categories_nightlife;
