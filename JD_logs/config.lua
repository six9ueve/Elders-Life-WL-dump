Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = true  											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "Elders" 							-- Bot Username
Config.avatar = "https://via.placeholder.com/30x30"				-- Bot Avatar
Config.communtiyName = "LOG"					-- Icon top of the Embed
Config.communtiyLogo = "https://via.placeholder.com/30x30"		-- Icon top of the Embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs
Config.weaponLogDelay = 1000		-- delay to wait after someone fired a weapon to check again in ms (put to 0 to disable) Best to keep this at atleast 1000

Config.depotLog = true  			-- set to false to disable the shooting weapon logs
Config.retraitLog = true

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs


-- Change color of the default embeds here
-- It used Decimal color codes witch you can get and convert here: https://jokedevil.com/colorPicker
Config.joinColor = "3863105" 		-- Player Connecting
Config.leaveColor = "15874618"		-- Player Disconnected
Config.chatColor = "10592673"		-- Chat Message
Config.shootingColor = "10373"		-- Shooting a weapon
Config.deathColor = "000000"		-- Player Died
Config.resourceColor = "15461951"	-- Resource Stopped/Started



Config.webhooks = {
	all = "game",
	chat = "https://discord.com/api/webhooks/922179537473765437/rx2SwVh7o4mzeNIbtWaBSFTTZ8OGi_2kAzTPFGvnBZRqcsvwqb5t4BnDKuVg9sscjwSm",
	me = "https://discord.com/api/webhooks/922179590787567616/zordSfA4Rl_0_MGriXhcCwD8wwhojuRPL0Iy38NShK6nXq8uccEnM3LH9gDcZVOp9K_n",
	joins = "https://discord.com/api/webhooks/922178814535168010/XATbj5xikbx6POET7Nk9ve9rPEGS3s7GvqEplmcLsnDraXeXuborEAseO2yCvO1jkKWQ",
	leaving = "https://discord.com/api/webhooks/922178861737840650/NV7zLQSL3LJb99uJotDevClbrw50n6tzebiIfFWPdj0sJtm_OJvPxq_885USDOvfBERO",
	deaths = "https://discord.com/api/webhooks/922178999881453588/X_ChU3PdlshXDsiFKqTCdhBQEVrjh_dIzTdh5-gHwDtpRa8pxi8m6aFzOkjOwlVzZGlC",
	deaths2= "https://discord.com/api/webhooks/1021180014336684042/ez9EIfnMZZNUL0IoJ5cbuOr3xJaH7N-LyP51cMmFZ4yUGS_wSfYp5e968IIvskI4bBAB",
	shooting = "https://discord.com/api/webhooks/922178908470796338/t38DcCnvVZfEzzXWB8wOJUuY70Ch3aNPqRw7cEfLVxHwh8JDTiaCN-oOa5MCxIc7Aaz5",
	depot = "https://discord.com/api/webhooks/922179757204963389/3efMKci2ea6Iqq8L-XMg_IgIMF2qZOJ9OfsVtjFq5mjrWCSTy95q70-quTxUNPC51RtW",
	retrait = "https://discord.com/api/webhooks/922179807943458827/zmaBPO2XJYSZH0OZm8j_SehuXEfcPsrRJUtHR5otC_11TZyyyOAJyMgfd_PQLYfIxUkF",
	resources = "DISCORD_WEBHOOK",
	drogue = "https://discord.com/api/webhooks/922179125446320188/CbCg-R9J-KIXF1Ka1aSR-jsv9d9mDynMVREIzqk78vkKMZrTfTz2HWd-6brWcw4aXcHA",
	concess = "https://discord.com/api/webhooks/922179986822135920/4zO6PVuncXBQEWo-Ln9QTrlY8tOhv3FL_zvgBuHAWfVb1IuTsRQBG4LSrlOytAoQkv_0",
	retraitsociete = "https://discord.com/api/webhooks/922179913442791504/6SDEqqfvrCIHuNLLy5evq5CWvXI_uZ3SaiJc1PaQaIm4aW6wlMKp1Buo7CjSODvLrUYV",
	depotsociete = "https://discord.com/api/webhooks/922179860519063554/JHVSID0YgQtXGSsAzaXGtOPiqq3YjgyupZFv1j7TqBzW0CFZQ2tzHk6o554MJgew2Liu",
	chopchop = "https://discord.com/api/webhooks/922179435183079454/1LR1iT0Pw2UrdUF2ZmxA406zQ4IXxkURM6Gv5mSqsih44giIiMPfouhiR5g2esDj0MLC",
	wype = "https://discord.com/api/webhooks/921507570575892490/6QCSd_qrHyzw5oEAPXMyfQ0u3NHnBRVd-MCHSlYgTMWXpQj7__dtNmu2gtFCoY8KDJpa",
	object = "https://discord.com/api/webhooks/840356377197281290/-D-7DNObm4d7eiC0GBkpSfwUUMgMTei2SQSpqkp63zsSOJvbYXm72NaUmB41x-eRYA0a",
	pillule = "https://discord.com/api/webhooks/921507541383524390/WyXFcxW3lZFX5HiSuG29Vl6a40ZYxywovVOPcIHoVopUwNT7nG9yvJVIAgUGEnBPK3Y2",
	chirurgie = "https://discord.com/api/webhooks/922180188236841001/8lpePlfp2Inqbf7mFAIJaO6hvIpQC49RHXpQf-CIaGJvyRCOnuxOd6pyjJCZvcJ-wJw3",
	blackmarket = "https://discord.com/api/webhooks/922179310025068626/wmM4zFDDT2Wb5umwJCKIcag_eFDFB1l9iIgvb9gQMQwB2iPSetlrNQC2PzxajBjuWvCH",
	vote = "https://discord.com/api/webhooks/919262763258359838/7Zw1OnnUC6VWu0FG5PRfliSv35pEV_Ju2zbt_-3tHm8BjLy2HehMi-8QAvHtx7l8Z1m1",
	tig = "https://discord.com/api/webhooks/922180348983533588/yhOuBnv0dV1sbozSVl2VydSIEtA-MUBHmalWReHXes9zlX4W70UzwtQLkW02ktSx_0AV",
	weaponshop = "https://discord.com/api/webhooks/922179246246469682/nhNX1DlGAed0iKnztZPEBdU2iz4vvtjzT8STtspqt4vXmUIjClgLyPalGFiLaJCeXB7V",
	tag = "https://discord.com/api/webhooks/922179386290081892/Zcdxj7XSEKSOIcPvMWrld6tM28NVpiksNwPR-aIPtNr40woccJ13IP09wyZQQX989U6o",
	depotarme = "https://discord.com/api/webhooks/922179649017102436/fKKc9yg2wHUIgGVXQKAjegt7JE6PmN0HEQ57QjRxSFiy3OrhKMi-CzpCX6hzVBFJBA-l",
	retraitarme = "https://discord.com/api/webhooks/922179697381605427/7VU0q2bkFLE3epzQlnH-EGdkZbEN8BQrLmaWxMNYh5opCXVuYy4pP9Ublf9_gW0DmH80",
	blanchiement = "https://discord.com/api/webhooks/922179066092736522/rlDy_pwWGtkY8OS2775I9slxPBtYQxG6uF4JLHGtvf3WfYrcFq5D-m40ov8Hf7nRkBHs",
	rob = "https://discord.com/api/webhooks/914194896636760095/xpLCWOT3aJvksyn2mwQWZPH-ipm7vmkS-BGsNLtlOn5yMkfs8W-mNYPlKLM5sqc4c5rl",
	robArgent = "https://discord.com/api/webhooks/914204113598836816/uKzqN1NGlNQUrX60R33S933UUSJn4X_WPhuyp67LihJY945kGCPce3wCmbs5PdKIBtWA",
	robitem = "https://discord.com/api/webhooks/914205870060109844/QNFYCvP1jNrMc0m95_slQuD-fN11yu8De7TB86SukFqjaoyPcKesuwSiuDONk8l3CHqa",
	vente_drogue = "https://discord.com/api/webhooks/922179200427896842/EvgX5dLclipE3yOolixbLdCLe5C2EQqx_5CocYkxLAk1Ma4wutQba5YjHtys89COMg4E",
	casino = "https://discord.com/api/webhooks/957631451510243388/KiNOdzsp7vPT0_2DwXCsZeUpSHrTaRKK9MGEsGE-VCFMqEim6-2dYFjrN4eWaiDvbGep",
	itemretrait = "https://discord.com/api/webhooks/975870122285744128/1b-d-quBsZ1cvde6Gh0SNHSZ51MkR2CdlgOXy_K9SbIsRzu50Ni2bKmx9ci3mTo7Xx_p",
	itemdepot = "https://discord.com/api/webhooks/975870261343682570/wP2W9v49asuj-k30_wGdVFWmw_SH29gKf0JU6BSTs-cr7sPR83GButvp6OvVrdmwZc8R",
	itemdrop = "https://discord.com/api/webhooks/978348491376058438/K1UUXkhThsjknDjotFMaftEgdm83I3Z8elsghqXIVNUjwVBNKpmkcydVThJ4-JlcA5hf",
	itemdepotvoiture = "https://discord.com/api/webhooks/1002848116137021510/PHy7J6eKlwwWZZ0eyWHG4lK8D385XKI7WJtFk8t1Z2V0RxQbsl3ehKed3bFy--huPSC9",
	itemretraitvoiture = "https://discord.com/api/webhooks/1002848190351028254/eN1qZ5oXS55y3LRr9oJRMxam7jPVrMHTeH5QK_LKaKWVAW3PytnrbPvoAN5NbPH-IzXY",
	contract = "https://discord.com/api/webhooks/1009916549819281569/TjJ_M-AgNGz65b3trtxWdGvYmLoEdk7UAy5RxVA1cAAvPToQV2rSKS7FwV-qjxSxduya",
	unitex = "https://discord.com/api/webhooks/1059777976700518410/9Bf9Rr1X_rN1hBgrsDSebwGRDzOuQsWZQ9bkBRq3GUaVJWpUjcZx6FlmMgqAWsndN0TZ",





  -- How you add more logs is explained on https://docs.jokedevil.com/JD_logs
  }


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.1.0"
