local clientcode = {}

local function sendRequest(request)
    rednet.send(clientcode.serverId, request)
    local senderId, response = rednet.receive()
    return response
end

function clientcode.setuser(username)
    clientcode.username = username
end

function clientcode.setpass(password)
    clientcode.password = password
end

function clientcode.connect(serverId)
    clientcode.serverId = serverId
end

function clientcode.writefile(filePathServer, filePathClient)
    local fileContent = fs.open(filePathClient, "r").readAll()
    local request = {
        command = "write",
        filePathServer = filePathServer,
        content = fileContent
    }
    return sendRequest(request)
end

function clientcode.get(disk, filePath)
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

return clientcode
