import { createClient } from "@supabase/supabase-js";

export const supabase = createClient(
  "https://wbekftdbbgbvuybtvjoi.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndiZWtmdGRiYmdidnV5YnR2am9pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjgwODgxNTEsImV4cCI6MjA0MzY2NDE1MX0.j-bv1lYpTHBiCjFjlwpXGtLqoftFZRqazzoROas6gAA"
);
