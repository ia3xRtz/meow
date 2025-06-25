local function get(url)
    local req = (syn and syn.request) or (http and http.request) or (request) or (MachoWebRequest and function(t) return { Body = MachoWebRequest(t.Url) } end)
    if not req then error("HTTP requests not supported on this executor.") end
    local res = req({Url = url, Method = "GET"})
    return res.Body
end

local function decodeJson(str)
    local ok, result = pcall(function() return load("return " .. str)() end)
    return ok and result or error("Failed to decode JSON.")
end

-- روابط GitHub
local keysURL = "https://raw.githubusercontent.com/ia3xrtz/meow/main/keys.json"
local menuURL = "https://raw.githubusercontent.com/ia3xrtz/meow/main/menu.lua"

-- يطلب من المستخدم إدخال مفتاح
print("Enter your key:")
local userKey = io.read()

-- تحميل المفاتيح والتحقق منها
local keys = decodeJson(get(keysURL))
if keys[userKey] then
    print("Key valid. Loading menu...")
    local menuCode = get(menuURL)
    loadstring(menuCode)()
else
    print("Invalid key. Access denied.")
end
