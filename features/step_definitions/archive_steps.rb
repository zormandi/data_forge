Then /^the "(.*?)" archive should contain the following files:$/ do |archive_name, file_names|
  prep_for_fs_check do
    files_in_archive = (%x( tar -tf #{archive_name} )).split "\n"
    expect(files_in_archive).to eq file_names.raw.map { |row| row.first }
  end
end
