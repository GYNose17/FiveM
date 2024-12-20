RegisterTunnel.DevTools = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.setBanned(user_id, true)
        vRP.kick(source, "OPA!!! Bobinho, Não pode não..")
    end
end