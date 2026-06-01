CREATE TABLE users (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  username text UNIQUE NOT NULL,
  email text UNIQUE NOT NULL,
  password_hash text NOT NULL,
  virtual_coins integer DEFAULT 1000,
  created_at timestamp DEFAULT now(),
  last_sign_in timestamp
);

CREATE TABLE check_ins (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id uuid REFERENCES users(id),
  check_in_date date NOT NULL,
  coins_earned integer DEFAULT 50
);

CREATE TABLE predictions (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id uuid REFERENCES users(id),
  match_id text NOT NULL,
  predicted_winner text NOT NULL,
  coins_bet integer NOT NULL,
  result text DEFAULT 'pending',
  coins_earned integer DEFAULT 0,
  created_at timestamp DEFAULT now()
);

CREATE TABLE friendships (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id uuid REFERENCES users(id),
  friend_id uuid REFERENCES users(id),
  status text DEFAULT 'pending'
);

CREATE TABLE IF NOT EXISTS comments (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id uuid REFERENCES users(id),
  team_name text,
  topic_id text,
  content text NOT NULL,
  likes integer DEFAULT 0,
  created_at timestamp DEFAULT now()
);

ALTER TABLE comments ENABLE ROW LEVEL SECURITY;
CREATE POLICY "允许插入评论" ON comments FOR INSERT WITH CHECK (true);
CREATE POLICY "允许读取评论" ON comments FOR SELECT USING (true);
CREATE POLICY "允许更新评论" ON comments FOR UPDATE USING (true);
