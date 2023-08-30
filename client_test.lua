local example = require("example")

example.setuser("your_username")
example.setpass("your_password")
example.connect(123)

local success = example.writefile("server_folder/file.lua", "client_folder/file.lua")

if success then
    print("File written successfully.")
else
    print("Error writing the file.")
end

local content, error = example.get("disk1", "myfolder/file.lua")
if content then
    print(content)
else
    print("Error:", error)
end
