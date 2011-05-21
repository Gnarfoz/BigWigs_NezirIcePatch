local mod = BigWigs:NewBoss("Conclave of Wind - Nezir Ice Patches", 773)
if not mod then return end
mod:RegisterEnableMob(45870, 45871, 45872) -- Anshal, Nezir, Rohash

local icePatch = "~"..(GetSpellInfo(93130))

function mod:GetOptions()
	return {93130}, {[84645] = "Nezir"}
end

function mod:OnBossEnable()
	self:Log("SPELL_DAMAGE", "IcePatch", 93130)
	self:Log("SPELL_MISSED", "IcePatch", 93130)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Disable", 45871)
end

function mod:OnEngage(diff)
	if diff < 2 then
		mod:Disable()
		return
	end
	self:Bar(93130, icePatch, 15, 93130)
end

do
	local prev = 0
	function mod:IcePatch()
		local t = GetTime()
		if (t - prev) > 10 then
			prev = t
			self:SendMessage("BigWigs_StopBar", icePatch)
			self:Bar(93130, icePatch, 15, 93130)
		end
	end
end