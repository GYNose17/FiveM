-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("characters/Person","SELECT * FROM characters WHERE id = @id")
vRP.Prepare("characters/Phone","SELECT id FROM characters WHERE Phone = @Phone")
vRP.Prepare("characters/Delete","UPDATE characters SET Deleted = 1 WHERE id = @Passport")
vRP.Prepare("characters/UpdatePhone","UPDATE characters SET Phone = @Phone WHERE id = @Passport")
vRP.Prepare("characters/SetMedicplan","UPDATE characters SET Medic = @Medic WHERE id = @Passport")
vRP.Prepare("characters/UpdateMedicplan","UPDATE characters SET Medic = Medic + 2592000 WHERE id = @Passport")
vRP.Prepare("characters/AddBank","UPDATE characters SET Bank = Bank + @Bank WHERE id = @Passport")
vRP.Prepare("characters/RemBank","UPDATE characters SET Bank = Bank - @Bank WHERE id = @Passport")
vRP.Prepare("characters/AddFines","UPDATE characters SET Fines = Fines + @Fines WHERE id = @Passport")
vRP.Prepare("characters/RemFines","UPDATE characters SET Fines = Fines - @Fines WHERE id = @Passport")
vRP.Prepare("characters/AddTaxs","UPDATE characters SET Taxs = Taxs + @Taxs WHERE id = @Passport")
vRP.Prepare("characters/RemTaxs","UPDATE characters SET Taxs = Taxs - @Taxs WHERE id = @Passport")
vRP.Prepare("characters/UpdateGun","UPDATE characters SET Gun = @Gun WHERE id = @Passport")
vRP.Prepare("characters/UpdateDriver","UPDATE characters SET Driver = @Driver WHERE id = @Passport")
vRP.Prepare("characters/UserLicense","SELECT * FROM characters WHERE id = @id and License = @License")
vRP.Prepare("characters/Characters","SELECT * FROM characters WHERE License = @License and Deleted = 0")
vRP.Prepare("characters/InsertPrison","UPDATE characters SET Prison = Prison + @Prison WHERE id = @Passport")
vRP.Prepare("characters/ReducePrison","UPDATE characters SET Prison = Prison - @Prison WHERE id = @Passport")
vRP.Prepare("characters/CleanPrison","UPDATE characters SET Prison = 0 WHERE id = @Passport")
vRP.Prepare("characters/Count","SELECT COUNT(License) AS Amount FROM characters WHERE License = @License and Deleted = 0")
vRP.Prepare("characters/UpdateName","UPDATE characters SET Name = @Name, Lastname = @Lastname WHERE id = @Passport")
vRP.Prepare("characters/UpdateSex","UPDATE characters SET Sex = @Sex WHERE id = @Passport")
vRP.Prepare("characters/LastCharacter","SELECT id FROM characters WHERE License = @License ORDER BY id DESC LIMIT 1")
vRP.Prepare("characters/NewCharacter","INSERT INTO characters(License,Name,Lastname,Sex,Phone,Blood,Created) VALUES(@License,@Name,@Lastname,@Sex,@Phone,@Blood,UNIX_TIMESTAMP() + 259200)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("accounts/All","SELECT * FROM accounts")
vRP.Prepare("accounts/Account","SELECT * FROM accounts WHERE License = @License")
vRP.Prepare("accounts/NewAccount","INSERT INTO accounts(License) VALUES(@License)")
vRP.Prepare("accounts/Clean","UPDATE accounts SET Whitelist = 0 WHERE License = @License")
vRP.Prepare("accounts/SetWhitelist","UPDATE accounts SET Whitelist = @Whitelist WHERE id = @id")
vRP.Prepare("accounts/Rolepass","UPDATE accounts SET Rolepass = @Rolepass WHERE License = @License")
vRP.Prepare("accounts/SetPremium","UPDATE accounts SET Premium = @Premium WHERE License = @License")
vRP.Prepare("accounts/UpgradePremium","UPDATE accounts SET Premium = Premium + 2592000 WHERE License = @License")
vRP.Prepare("accounts/AddGemstone","UPDATE accounts SET Gemstone = Gemstone + @Gemstone WHERE License = @License")
vRP.Prepare("accounts/UpdateCharacters","UPDATE accounts SET Characters = Characters + 1 WHERE License = @License")
vRP.Prepare("accounts/RemoveGemstone","UPDATE accounts SET Gemstone = Gemstone - @Gemstone WHERE License = @License")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("playerdata/GetData","SELECT * FROM playerdata WHERE Passport = @Passport AND Name = @Name")
vRP.Prepare("playerdata/SetData","REPLACE INTO playerdata(Passport,Name,Information) VALUES(@Passport,@Name,@Information)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("entitydata/GetData","SELECT * FROM entitydata WHERE Name = @Name")
vRP.Prepare("entitydata/RemoveData","DELETE FROM entitydata WHERE Name = @Name")
vRP.Prepare("entitydata/SetData","REPLACE INTO entitydata(Name,Information) VALUES(@Name,@Information)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("vehicles/All","SELECT * FROM vehicles")
vRP.Prepare("vehicles/Drift","UPDATE vehicles SET drift = 1 WHERE Plate = @Plate")
vRP.Prepare("vehicles/plateVehicles","SELECT * FROM vehicles WHERE plate = @plate")
vRP.Prepare("vehicles/UserVehicles","SELECT * FROM vehicles WHERE Passport = @Passport")
vRP.Prepare("vehicles/removeVehicles","DELETE FROM vehicles WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/selectVehicles","SELECT * FROM vehicles WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/paymentArrest","UPDATE vehicles SET arrest = 0 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/moveVehicles","UPDATE vehicles SET Passport = @OtherPassport WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/plateVehiclesUpdate","UPDATE vehicles SET plate = @plate WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/rentalVehiclesDays","UPDATE vehicles SET rental = rental + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/arrestVehicles","UPDATE vehicles SET arrest = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/updateVehiclesTax","UPDATE vehicles SET tax = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/rentalVehiclesUpdate","UPDATE vehicles SET rental = UNIX_TIMESTAMP() + 2592000 WHERE Passport = @Passport AND vehicle = @vehicle")
vRP.Prepare("vehicles/addVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,tax) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 604800)")
vRP.Prepare("vehicles/rentalVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,rental,tax) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 2592000,UNIX_TIMESTAMP() + 604800)")
vRP.Prepare("vehicles/initialVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,rental,tax) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 259200,UNIX_TIMESTAMP() + 259200)")
vRP.Prepare("vehicles/dismantleVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,mode,dismantle,rental,tax) VALUES(@Passport,@vehicle,@plate,@work,'dismantle',UNIX_TIMESTAMP() + 86400,UNIX_TIMESTAMP() + 86400,UNIX_TIMESTAMP() + 86400)")
vRP.Prepare("vehicles/updateVehicles","UPDATE vehicles SET engine = @engine, body = @body, health = @health, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres, brakes = @brakes, nitro = @nitro WHERE Passport = @Passport AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNEDS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("banneds/GetBanned","SELECT * FROM banneds WHERE License = @License")
vRP.Prepare("banneds/RemoveBanned","DELETE FROM banneds WHERE License = @License")
vRP.Prepare("banneds/GetToken","SELECT * FROM banneds WHERE Token = @Token LIMIT 1")
vRP.Prepare("banneds/InsertToken","INSERT INTO banneds(License,Token) VALUES(@License,@Token)")
vRP.Prepare("banneds/InsertBanned","INSERT INTO banneds(License,Token,Time) VALUES(@License,@Token,UNIX_TIMESTAMP() + 86400 * @Time)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("chests/GetChests","SELECT * FROM chests WHERE Name = @Name")
vRP.Prepare("chests/RemBank","UPDATE chests SET Bank = Bank - @Bank WHERE Name = @Name")
vRP.Prepare("chests/AddBank","UPDATE chests SET Bank = Bank + @Bank WHERE Name = @Name")
vRP.Prepare("chests/UpdateChests","UPDATE chests SET Weight = Weight + 10 WHERE Name = @Name")
vRP.Prepare("chests/AddChests","INSERT IGNORE INTO chests(Name,Permission) VALUES(@Name,@Name)")
vRP.Prepare("chests/DowngradeChests","UPDATE chests SET Weight = Weight / 2 WHERE Name = @Name")
vRP.Prepare("chests/UpgradeChests","UPDATE chests SET Weight = Weight + Weight WHERE Name = @Name")
vRP.Prepare("chests/Premium","UPDATE chests SET Premium = @Premium WHERE Name = @Name")
vRP.Prepare("chests/UpdateWeight","UPDATE chests SET Weight = Weight + (10 * @Multiplier), Slots = Slots + (5 * @Multiplier) WHERE Name = @Name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("races/Result","SELECT * FROM races WHERE Race = @Race AND Passport = @Passport")
vRP.Prepare("races/Ranking","SELECT * FROM races WHERE Race = @Race ORDER BY Points ASC LIMIT 5")
vRP.Prepare("races/TopFive","SELECT * FROM races WHERE Race = @Race ORDER BY Points ASC LIMIT 1 OFFSET 4")
vRP.Prepare("races/Records","UPDATE races SET Points = @Points, Vehicle = @Vehicle WHERE Race = @Race AND Passport = @Passport")
vRP.Prepare("races/Insert","INSERT INTO races(Race,Passport,Name,Vehicle,Points) VALUES(@Race,@Passport,@Name,@Vehicle,@Points)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("fidentity/Result","SELECT * FROM fidentity WHERE id = @id")
vRP.Prepare("fidentity/GetIdentity","SELECT id FROM fidentity ORDER BY id DESC LIMIT 1")
vRP.Prepare("fidentity/NewIdentity","INSERT INTO fidentity(Name,Lastname,Blood) VALUES(@Name,@Lastname,@Blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("warehouse/All","SELECT * FROM warehouse")
vRP.Prepare("warehouse/Sell","DELETE FROM warehouse WHERE Name = @Name")
vRP.Prepare("warehouse/Informations","SELECT * FROM warehouse WHERE Name = @Name")
vRP.Prepare("warehouse/Password","UPDATE warehouse SET Password = @Password WHERE Name = @Name")
vRP.Prepare("warehouse/Transfer","UPDATE warehouse SET Passport = @Passport WHERE Name = @Name")
vRP.Prepare("warehouse/Acess","SELECT * FROM warehouse WHERE Name = @Name AND Password = @Password")
vRP.Prepare("warehouse/Tax","UPDATE warehouse SET Tax = UNIX_TIMESTAMP() + 2592000 WHERE Name = @Name")
vRP.Prepare("warehouse/Upgrade","UPDATE warehouse SET Weight = Weight + (10 * @Multiplier) WHERE Name = @Name")
vRP.Prepare("warehouse/Buy","INSERT INTO warehouse(Name,Password,Passport,Tax) VALUES(@Name,@Password,@Passport,UNIX_TIMESTAMP() + 2592000)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("propertys/All","SELECT * FROM propertys")
vRP.Prepare("propertys/Sell","DELETE FROM propertys WHERE Name = @Name")
vRP.Prepare("propertys/Exist","SELECT * FROM propertys WHERE Name = @Name")
vRP.Prepare("propertys/Serial","SELECT * FROM propertys WHERE Serial = @Serial")
vRP.Prepare("propertys/Garages","SELECT * FROM propertys WHERE Garage IS NOT NULL")
vRP.Prepare("propertys/AllUser","SELECT * FROM propertys WHERE Passport = @Passport")
vRP.Prepare("propertys/Item","UPDATE propertys SET Item = Item + 1 WHERE Name = @Name")
vRP.Prepare("propertys/Garage","UPDATE propertys SET Garage = @Garage WHERE Name = @Name")
vRP.Prepare("propertys/Credentials","UPDATE propertys SET Serial = @Serial WHERE Name = @Name")
vRP.Prepare("propertys/Vault","UPDATE propertys SET Vault = Vault + @Weight WHERE Name = @Name")
vRP.Prepare("propertys/Transfer","UPDATE propertys SET Passport = @Passport WHERE Name = @Name")
vRP.Prepare("propertys/Fridge","UPDATE propertys SET Fridge = Fridge + @Weight WHERE Name = @Name")
vRP.Prepare("propertys/Check","SELECT * FROM propertys WHERE Name = @Name AND Passport = @Passport")
vRP.Prepare("propertys/Tax","UPDATE propertys SET Tax = UNIX_TIMESTAMP() + 2592000 WHERE Name = @Name")
vRP.Prepare("propertys/Buy","INSERT INTO propertys(Name,Interior,Passport,Serial,Vault,Fridge,Tax) VALUES(@Name,@Interior,@Passport,@Serial,@Vault,@Fridge,@Tax)")

-----------------------------------------------------------------------------------------------------------------------------------------
-- FINES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("fines/List","SELECT * FROM fines WHERE Passport = @Passport")
vRP.Prepare("fines/Remove","DELETE FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/Check","SELECT * FROM fines WHERE Passport = @Passport AND id = @id")
vRP.Prepare("fines/Add","INSERT INTO fines(Passport,Name,Date,Hour,Value,Message) VALUES(@Passport,@Name,@Date,@Hour,@Value,@Message)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("taxs/List","SELECT * FROM taxs WHERE Passport = @Passport")
vRP.Prepare("taxs/Remove","DELETE FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/Check","SELECT * FROM taxs WHERE Passport = @Passport AND id = @id")
vRP.Prepare("taxs/Add","INSERT INTO taxs(Passport,Name,Date,Hour,Value,Message) VALUES(@Passport,@Name,@Date,@Hour,@Value,@Message)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("transactions/List","SELECT * FROM transactions WHERE Passport = @Passport ORDER BY id DESC LIMIT @Limit")
vRP.Prepare("transactions/Add","INSERT INTO transactions(Passport,Type,Date,Value,Balance,Timeset) VALUES(@Passport,@Type,@Date,@Value,@Balance,UNIX_TIMESTAMP() + 259200)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("investments/Remove","DELETE FROM investments WHERE Passport = @Passport")
vRP.Prepare("investments/Check","SELECT * FROM investments WHERE Passport = @Passport")
vRP.Prepare("investments/Add","INSERT INTO investments(Passport,Deposit,Last) VALUES(@Passport,@Deposit,UNIX_TIMESTAMP() + 86400)")
vRP.Prepare("investments/Invest","UPDATE investments SET Deposit = Deposit + @Value, Last = UNIX_TIMESTAMP() + 86400 WHERE Passport = @Passport")
vRP.Prepare("investments/Actives","UPDATE investments SET Monthly = Monthly + FLOOR((Deposit + Liquid) * 0.10), Liquid = Liquid + FLOOR((Deposit + Liquid) * 0.025), Last = UNIX_TIMESTAMP() + 86400 WHERE Last < UNIX_TIMESTAMP()")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("painel/List","SELECT * FROM painel WHERE Permission = @Permission ORDER BY id DESC LIMIT 20")
vRP.Prepare("painel/Add","INSERT INTO painel(Passport,Permission,Type,Price,Timeset) VALUES(@Passport,@Permission,@Type,@Price,UNIX_TIMESTAMP() + 259200)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("prison/Clean", "DELETE FROM police_prison WHERE nuser_id = @nuser_id")
vRP.Prepare("prison/Personal", "SELECT * FROM police_prison WHERE nuser_id = @nuser_id ORDER BY id DESC")
vRP.Prepare("prison/Get", "SELECT * FROM police_prison WHERE id = @id ORDER BY id DESC")
vRP.Prepare("prison/Insert","INSERT INTO police_prison(police,nuser_id,services,fines,text,date,cops,association,residual,url) VALUES(@police,@nuser_id,@services,@fines,@text,@date,@cops,@association,@residual,@url)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GUNLICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("gunlicense/Insert","INSERT INTO police_gunlicense(identity,user_id,portType,serial,nidentity,date,weapon,exam) VALUES(@identity,@user_id,@portType,@serial,@nidentity,@date,@weapon,@exam)")
vRP.Prepare("gunlicense/List", "SELECT * FROM police_gunlicense ORDER BY portId DESC")
vRP.Prepare("gunlicense/Personal", "SELECT * FROM police_gunlicense WHERE portId = @portId")
vRP.Prepare("gunlicense/Update", "UPDATE police_gunlicense SET identity = @identity,user_id = @user_id,portType = @portType,serial = @serial,nidentity = @nidentity,date = @date,weapon = @weapon,exam = @exam WHERE portId = @portId")
vRP.Prepare("gunlicense/Remove", "DELETE FROM police_gunlicense WHERE portId = @portId")
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("reports/List", "SELECT * FROM police_reports ORDER BY id DESC")
vRP.Prepare("reports/Solved", "UPDATE police_reports SET solved = 0, updated_at = @updated_at WHERE id = @id")
vRP.Prepare("reports/Insert", "INSERT INTO police_reports(victim_id, police_name, solved, victim_name, created_at, victim_report, updated_at) VALUES(@victim_id, @police_name, @solved, @victim_name, @created_at, @victim_report, @updated_at)")
vRP.Prepare("reports/Remove", "DELETE FROM police_reports WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WARRANTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("warrants/List", "SELECT * FROM police_warrants ORDER BY id DESC")
vRP.Prepare("warrants/Personal", "SELECT * FROM police_warrants WHERE id = @id")
vRP.Prepare("warrants/Remove", "DELETE FROM police_warrants WHERE id = @id")
vRP.Prepare("warrants/Insert", "INSERT INTO police_warrants(user_id, identity, status, nidentity, timeStamp, reason) VALUES(@user_id, @identity, @status, @nidentity, @timeStamp, @reason)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARTABLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("baixada/Playerdata","DELETE FROM playerdata WHERE Information = '[]' OR Information = '{}'")
vRP.Prepare("baixada/Entitydata","DELETE FROM entitydata WHERE Information = '[]' OR Information = '{}'")
vRP.Prepare("baixada/Transactions","DELETE FROM transactions WHERE UNIX_TIMESTAMP() >= Timeset")
vRP.Prepare("baixada/Painel","DELETE FROM painel WHERE UNIX_TIMESTAMP() >= Timeset")
vRP.Prepare("baixada/Premium","UPDATE accounts SET Premium = '0' WHERE UNIX_TIMESTAMP() >= Premium")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	vRP.Query("baixada/Premium")
	vRP.Query("baixada/Playerdata")
	vRP.Query("baixada/Entitydata")
	vRP.Query("baixada/Transactions")
end)