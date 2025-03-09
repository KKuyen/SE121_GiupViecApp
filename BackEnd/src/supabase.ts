import { createClient } from "@supabase/supabase-js";

const SUPABASE_URL = "https://wbekftdbbgbvuybtvjoi.supabase.co"; // Thay bằng URL của bạn
const SUPABASE_ANON_KEY =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndiZWtmdGRiYmdidnV5YnR2am9pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjgwODgxNTEsImV4cCI6MjA0MzY2NDE1MX0.j-bv1lYpTHBiCjFjlwpXGtLqoftFZRqazzoROas6gAA"; // Thay bằng Anon Key của bạn

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
