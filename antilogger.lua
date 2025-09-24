local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

print("[Anti-Logger] Blocking any shady requests...")

local dangerousDomains = {
    "webhook",
    "webhook.party"
}

local function isBlockedUrl(url)
    url = tostring(url):lower()
    for _, keyword in ipairs(dangerousDomains) do
        if url:find(keyword) then
            return true, "Keyword: " .. keyword
        end
    end
    return false
end

local function blockAndWarn(url, reason)
    warn("Blocked request to: " .. url .. " | Reason: " .. reason)
end

local function handleHttpRequest(requestFunction)
    return function(args)
        local url = args.Url or args.URL or ""
        local blocked, reason = isBlockedUrl(url)
        if blocked then
            blockAndWarn(url, reason)
            return nil
        end
        return requestFunction(args)
    end
end

if getfenv().request then
    local originalRequest = getfenv().request
    pcall(function()
        hookfunction(originalRequest, handleHttpRequest(originalRequest))
    end)
end

if getfenv().http_request then
    local originalHttpRequest = getfenv().http_request
    pcall(function()
        hookfunction(originalHttpRequest, handleHttpRequest(originalHttpRequest))
    end)
end

if syn and syn.request then
    local originalSynRequest = syn.request
    pcall(function()
        hookfunction(originalSynRequest, handleHttpRequest(originalSynRequest))
    end)
end

if fluxus and fluxus.request then
    local originalFluxusRequest = fluxus.request
    pcall(function()
        hookfunction(originalFluxusRequest, handleHttpRequest(originalFluxusRequest))
    end)
end

pcall(function()
    local originalRequestAsync = HttpService.RequestAsync
    hookfunction(originalRequestAsync, function(self, args)
        local url = args.Url or args.URL or ""
        local blocked, reason = isBlockedUrl(url)
        if blocked then
            blockAndWarn(url, reason)
            return nil
        end
        return originalRequestAsync(self, args)
    end)
end)
