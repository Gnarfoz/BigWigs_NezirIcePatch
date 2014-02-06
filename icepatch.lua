local mod = BigWigs:NewBoss("Conclave of Wind - Nezir Ice Patches", 773)
if not mod then return end
mod:RegisterEnableMob(45870, 45871, 45872) -- Anshal, Nezir, Rohash

local icePatch = "~"..(GetSpellInfo(86111))

function mod:GetOptions()
	return {86111}, {[86111] = -3178} -- -3178 = Nezir
end

function mod:OnBossEnable()
	self:Log("SPELL_DAMAGE", "IcePatch", 86111)
	self:Log("SPELL_MISSED", "IcePatch", 86111)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("Disable", 45871)
end

function mod:OnEngage(diff)
	if diff < 2 then
		mod:Disable()
		return
	end
	self:Bar(86111, 15, icePatch, 86111)
end

do
	local prev = 0
	function mod:IcePatch()
		local t = GetTime()
		if (t - prev) > 10 then
			prev = t
			self:SendMessage("BigWigs_StopBar", icePatch)
			self:Bar(86111, 15, icePatch, 86111)
		end
	end
end