-- Remove the one-time upload permission after uploading the bundled assets.
drop policy if exists "Temporary GOC CTU asset upload" on storage.objects;
