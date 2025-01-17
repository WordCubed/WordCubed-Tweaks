#****************************************************************************
#**
#**  File     :  /data/units/XRS0205/XRS0205_script.lua
#**  Author(s):  Jessica St. Croix
#**
#**  Summary  :  Cybran Counter-Intelligence Boat Script
#**
#**  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local CSeaUnit = import('/lua/cybranunits.lua').CSeaUnit
local CIFSmartCharge = import('/lua/cybranweapons.lua').CIFSmartCharge

XRS0205 = Class(CSeaUnit) {

    Weapons = {
        AntiTorpedo = Class(CIFSmartCharge) {},
    },

    OnStopBeingBuilt = function(self,builder,layer)
        CSeaUnit.OnStopBeingBuilt(self,builder,layer)
        self.AnimManip = CreateAnimator(self)
        self.Trash:Add(self.AnimManip)
        self.DelayedCloakThread = self:ForkThread(self.CloakDelayed)
    end,

    CloakDelayed = function(self)
        if not self.Dead then
            WaitSeconds(2)
            self.IntelDisables['CloakField']['ToggleBit3'] = true
            self:EnableUnitIntel('ToggleBit3', 'CloakField')
        end
        KillThread(self.DelayedCloakThread)
        self.DelayedCloakThread = nil
    end,

}

TypeClass = XRS0205