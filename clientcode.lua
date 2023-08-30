local rednet = peripheral.wrap("back")
local serverId = 123 -- Replace with the actual server's ID

local api = {}

local function sendRequest(request)
    rednet.send(serverId, request)
    local senderId, response = rednet.receive()
    return response
end

function api.setuser(username)
    api.username = username
end

function api.setpass(password)
    api.password = password
end

function api.connect(serverId)
    api.serverId = serverId
end

function api.writefile(filePathServer, filePathClient)
    local request = {
        command = "write",
        filePathServer = filePathServer,
        filePathClient = filePathClient,
        content = fs.open(filePathClient, "r").readAll()
    }
    return sendRequest(request)
end

function api.get(disk, filePath)
    local request = {
        command = "read",
        disk = disk,
        filePath = filePath
    }
    local response = sendRequest(request)
    if response.success then
        return response.content
    else
        return nil, response.error
    end
end

return api
