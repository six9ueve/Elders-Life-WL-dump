ChargeOn = false
ChargeEndCommand = "endcharge"  ---command used to finish charging
ChargeBlipOn = false  --- To see the blips of the charging stations
PowerBankFillingTime = 10 -- seconds
PowerBank = 1  -- Adjust this part how much you want to fill in how many seconds

NormalChargingFillingTime = 5 -- seconds
NormalCharging = 1  -- Adjust this part how much you want to fill in how many seconds
NormalChargingPropName = "gks_charge_normal"
NormalChargePay = 30  -- pay * percent

FastChargingFillingTime = 5 -- seconds
FastCharging = 3  -- Adjust this part how much you want to fill in how many seconds
FastChargingPropName = "gks_charge_fast"
FastChargePay = 50  -- pay * percent

ChargeEyeTarget = false

Charge = {
    ["twitterdata"] = 0.1,
    ["twitterlike"] = 0.1,
    ["twitterpost"] = 0.1,

    ["instapost"] = 0.1,
    ["instalike"] = 0.1,
    ["instadata"] = 0.1,

    ["carsellerdata"] = 0.1,
    ["carseller"] = 0.1,
    ["facetime"] = 0.1,

    ["tindermessage"] = 0.1,
    ["tindermatch"] = 0.1,

    ["gallerydata"] = 0.1,
    ["gallerypost"] = 0.1,
    ["darkchatdata"] = 0.1,
    ["darkchatpost"] = 0.1,

    ["game"] = 0.1,
    ["yellowdata"] = 0.1,
    ["yellowpost"] = 0.1,

    ["banktransfer"] = 0.1,

    ["billing"] = 0.1,
    ["valetdata"] = 0.1,

    ["addcontact"] = 0.1,
    ["groupcrate"] = 0.1,

    ["jobmessage"] = 0.1,
    ["sendmessage"] = 0.1,

    ["calling"] = 0.1,
    ["youtube"] = 0.1,
    ["music"] = 0.1,
}

PhoneNormalCharging = {
	vector4(-55.38, -1070.91, 27.33, 0.0),
}

PhoneFastCharging = {
	vector4(-50.38, -1070.91, 27.33, 0.0),
}