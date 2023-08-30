local rednet = peripheral.wrap("back")
local clientcode = require("clientcode")

clientcode.setuser("your_username")
clientcode.setpass("your_password")
clientcode.connect(78) -- Set the correct server ID here

local success = clientcode.writefile("server_folder/file.lua", "client_folder/file.lua")

if success then
    print("File written successfully.")
else
    print("Error writing the file.")
end

local content, error = clientcode.get("disk1", "myfolder/file.lua")
if content then
    print(content)
else
    print("Error:", error)
end
