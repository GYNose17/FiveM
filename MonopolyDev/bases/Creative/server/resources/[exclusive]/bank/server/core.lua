-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
Baixada = {}
Tunnel.bindInterface("bank", Baixada)

local Active = {}
local yield = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local Next = GetGameTimer()
    while true do
        if os.time() >= Next then
            Next = os.time() + 3600
            vRP.Query("investments/Actives")
        end
        Wait(10 * 1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Home()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Consult = vRP.Query("investments/Check", { Passport = Passport })
        if Consult[1] then
            yield = Consult[1]["Monthly"]
        end
        return {
            Passport = Passport,
            transactions = Transactions(Passport),
            balance = vRP.Identity(Passport)["Bank"],
            yield = yield
        }
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONHISTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.TransactionHistory()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        return Transactions(Passport, 50)
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Deposit(Amount)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and nil == Active[Passport] and parseInt(Amount) > 0 then
        Active[Passport] = true
        if vRP.ConsultItem(Passport, "dollars", Amount) and vRP.TakeItem(Passport, "dollars", Amount) then
            vRP.GiveBank(Passport, Amount)
        end
        Active[Passport] = nil
        return {
            transactions = Transactions(Passport),
            balance = vRP.Identity(Passport).Bank
        }
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Withdraw(Amount)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and nil == Active[Passport] and parseInt(Amount) > 0 then
        Active[Passport] = true
        vRP.WithdrawCash(Passport, Amount)
        Active[Passport] = nil
        return {
            transactions = Transactions(Passport),
            balance = vRP.Identity(Passport).Bank
        }
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Transfer(OtherPassport, Amount)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and nil == Active[Passport] and parseInt(Amount) > 0 then
        Active[Passport] = true
        if vRP.Identity(OtherPassport) and vRP.PaymentBank(Passport, Amount) then
            vRP.GiveBank(OtherPassport, Amount)
        end
        Active[Passport] = nil
        return {
            transactions = Transactions(Passport),
            balance = vRP.Identity(Passport).Bank
        }
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Transactions(Passport, Limit)
    Limit = Limit or 4
    local transactions = {}
    local Consult = vRP.Query("transactions/List", { Passport = Passport, Limit = Limit })
    if Consult[1] then
        for _, k in pairs(Consult) do
            transactions[#transactions + 1] = {
                balance = k.Balance,
                value = k.Value,
                date = k.Date,
                type = k.Type
            }
        end
    end
    return transactions
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FINES
-----------------------------------------------------------------------------------------------------------------------------------------
function Fines(Passport)
    local Consult = vRP.Query("fines/List", { Passport = Passport })
    local fines = {}
    if Consult[1] then
        for k, v in pairs(Consult) do
            fines[k] = {
                id = v.id,
                name = v.Name,
                value = v.Value,
                date = v.Date,
                hour = v.Hour,
                message = v.Message
            }
        end
    end
    return fines
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FINELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.FineList()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        return Fines(Passport)
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.FinePayment(id)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and nil == Active[Passport] then
        Active[Passport] = true
        local Consult = vRP.Query("fines/Check", { id = id, Passport = Passport })
        if Consult[1] then
            if vRP.PaymentBank(Passport, Consult[1].Value) then
                vRP.Query("fines/Remove", { id = id, Passport = Passport })
                vRP.RemoveFine(Passport, Consult[1].Value)
                Active[Passport] = nil
                return true
            else
                TriggerClientEvent("Notify", source, "vermelho", "<b>Dólares</b> insuficientes.", "Aviso", 5000)
            end
        end
        Active[Passport] = nil
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENTALL
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.FinePaymentAll()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and nil == Active[Passport] then
        Active[Passport] = true
        local Consult = vRP.Query("fines/List", { Passport = Passport })
        for _, k in pairs(Consult) do
            if vRP.PaymentBank(Passport, k.Value) then
                vRP.Query("fines/Remove", { id = k.id, Passport = Passport })
                vRP.RemoveFine(Passport, k.Value)
                Active[Passport] = nil
            end
        end
        Active[Passport] = nil
        return true
    end
    return Fines(Passport)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXS
-----------------------------------------------------------------------------------------------------------------------------------------
function Taxs(Passport)
    local Consult = vRP.Query("taxs/List", { Passport = Passport })
    local taxs = {}
    if Consult[1] then
        for k, v in pairs(Consult) do
            taxs[k] = {
                id = v.id,
                name = v.Name,
                value = v.Value,
                date = v.Date,
                hour = v.Hour,
                message = v.Message
            }
        end
    end
    return taxs
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.TaxList()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        return Taxs(Passport)
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.TaxPayment(id)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and nil == Active[Passport] then
        Active[Passport] = true
        local Consult = vRP.Query("taxs/Check", { id = id, Passport = Passport })
        if Consult[1] and vRP.PaymentBank(Passport, Consult[1].Value) then
            vRP.RemoveTax(Passport, Consult[1].Value)
            vRP.Query("taxs/Remove", { id = id, Passport = Passport })
            Active[Passport] = nil
            return true
        end
        Active[Passport] = nil
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Investments()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Consult = vRP.Query("investments/Check", { Passport = Passport })
        if Consult[1] then
            return {
                total = Consult[1].Monthly + Consult[1].Liquid,
                brute = Consult[1].Monthly,
                liquid = Consult[1].Liquid,
                deposit = Consult[1].Deposit
            }
        end
        return {
            deposit = 0,
            liquid = 0,
            brute = 0,
            total = 0
        }
    end
    return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.Invest(Amount)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and not Active[Passport] and parseInt(Amount) > 0 then
        Active[Passport] = true
        if vRP.PaymentBank(Passport, Amount) then
            if vRP.Query("investments/Check", { Passport = Passport })[1] then
                vRP.Query("investments/Invest", { Value = Amount, Passport = Passport })
            else
                vRP.Query("investments/Add", { Deposit = Amount, Passport = Passport })
            end
            Active[Passport] = nil
            return true
        end
        Active[Passport] = nil
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTRESCUE
-----------------------------------------------------------------------------------------------------------------------------------------
function Baixada.InvestRescue()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and not Active[Passport] then
        Active[Passport] = true
        local Consult = vRP.Query("investments/Check", { Passport = Passport })
        if Consult[1] then
            vRP.Query("investments/Remove", { Passport = Passport })
            vRP.GiveBank(Passport, Consult[1].Deposit + Consult[1].Liquid)
        end
        Active[Passport] = nil
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddTransactions", function(Passport, Type, Value)
    local Identity = vRP.Identity(Passport)
    if Identity and Identity.Bank then
        vRP.Query("transactions/Add", {
            Balance = Identity.Bank,
            Value = Value,
            Date = os.date("%d/%m/%Y"),
            Type = Type,
            Passport = Passport
        })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTAXS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddTaxs", function(Passport, Name, Value, Message)
    if vRP.Identity(Passport) then
        vRP.Query("taxs/Add", {
            Message = Message,
            Value = Value,
            Hour = os.date("%H:%M"),
            Date = os.date("%d/%m/%Y"),
            Name = Name,
            Passport = Passport
        })

        vRP.GiveTax(Passport, Value)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDFINES
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddFines", function(Passport, OtherPassport, Value, Message)
    if vRP.Identity(Passport) then
        vRP.Query("fines/Add", {
            Message = Message,
            Value = Value,
            Hour = os.date("%H:%M"),
            Date = os.date("%d/%m/%Y"),
            Name = vRP.FullName(OtherPassport),
            Passport = OtherPassport
        })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
    if Active[Passport] then
        Active[Passport] = nil
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Taxs", Taxs)
exports("Fines", Fines)
exports("Transactions", Transactions)