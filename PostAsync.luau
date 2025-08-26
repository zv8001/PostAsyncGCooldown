local WQ = {}
local GCooldown = false
local HttpService = game:GetService("HttpService")
local MessagingService = game:GetService("MessagingService")
local Lockdown = true


WQ.PostAsync = function(url,data,content_type:Enum.HttpContentType,compress:boolean,headers:any)
	if Lockdown then
		error("SubscribeAsync Failure This Server is unable to PostAsync")
	else
		if not GCooldown then
			GCooldown=true
			task.delay(2,function() GCooldown=false end)
			local s,e = pcall(function()
				return MessagingService:PublishAsync("GCooldown",true)
			end)
			if not s then error(e) end

			local s,r= pcall(function()
				return HttpService:PostAsync(url,data,content_type,compress,headers)
			end)
			if not s then error(r) end
		else
			return false
		end
	end
end
local S,E = pcall(function()
	MessagingService:SubscribeAsync("GCooldown",function()
		print("Webhook Global cooldown activated.")
		GCooldown=true
		task.delay(2,function()
			GCooldown=false
		end)
	end)
end)

if S then
	Lockdown=false
end


return WQ
