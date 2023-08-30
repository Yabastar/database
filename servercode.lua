local rednet = peripheral.wrap("back")
local fs = fs

local correctUsername = "your_username"
local correctPassword = "your_password"

local function grantAccess(filePath)
    local content = fs.open(filePath, "r").readAll()
    return content
end

local api = {}

function api.authenticate(username, password)
    return username == correctUsername and password == correctPassword
end

function api.processRequest(request)
    local response = {}

    if request.command == "write" then
        local filePath = request.filePathServer
        fs.makeDir(fs.getDir(filePath))
        local file = fs.open(filePath, "w")
        file.write(request.content)
        file.close()
        response.success = true
    elseif request.command == "read" then
        local filePath = request.disk .. "/" .. request.filePath
        local success, content = pcall(grantAccess, filePath)

        if success then
            response.success = true
            response.content = content
        else
            response.success = false
            response.error = "Access denied or file not found."
        end
    else
        response.success = false
        response.error = "Invalid command."
    end

    return response
end

function api.run()
    rednet.open("back")

    while true do
        local senderId, request = rednet.receive()

        if type(request) == "table" then
            local response = api.processRequest(request)
            rednet.send(senderId, response)
        end
    end
end

return api
