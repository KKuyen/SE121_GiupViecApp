import { useState } from "react";
import { createClient } from "@supabase/supabase-js";
import { Button, Input, message } from "antd";

const supabase = createClient(
  "https://wbekftdbbgbvuybtvjoi.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndiZWtmdGRiYmdidnV5YnR2am9pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjgwODgxNTEsImV4cCI6MjA0MzY2NDE1MX0.j-bv1lYpTHBiCjFjlwpXGtLqoftFZRqazzoROas6gAA"
);

export default function Activities() {
  const [file, setFile] = useState(null);
  const [imageUrl, setImageUrl] = useState("");
  const [loading, setLoading] = useState(false);

  const handleFileChange = (event) => {
    setFile(event.target.files[0]);
  };

  const uploadImage = async () => {
    if (!file) {
      message.error("Please select a file to upload.");
      return;
    }

    setLoading(true);

    const fileName = `${Date.now()}_${file.name}`;
    const { data, error } = await supabase.storage
      .from("images")
      .upload(fileName, file);

    if (error) {
      message.error("Failed to upload image.");
      console.error("Error uploading image:", error);
      setLoading(false);
      return;
    }

    const publicURL = supabase.storage.from("images").getPublicUrl(fileName);
    setImageUrl(publicURL.data.publicUrl);
    alert("Image uploaded successfully!");

    setLoading(false);
  };

  return (
    <div className="p-4 border rounded-xl shadow-md w-80 flex flex-col gap-4">
      <Input type="file" accept="image/*" onChange={handleFileChange} />
      <Button onClick={uploadImage} disabled={loading}>
        {loading ? "Đang tải lên..." : "Tải ảnh lên"}
      </Button>
      {imageUrl && (
        <div>
          <p>Ảnh đã tải lên:</p>
          <img src={imageUrl} alt="Uploaded" className="w-full rounded-lg" />
          <p className="break-all text-sm">{imageUrl}</p>
        </div>
      )}
    </div>
  );
}
