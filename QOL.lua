RunTimer = 120
KeepAccelerate = {2, 3, 4, 5, 201, 202}
Done = 0
Valor = 30
function _OnFrame()
    World = ReadByte(Now + 0x00)
    Room = ReadByte(Now + 0x01)
    Place = ReadShort(Now + 0x00)
    Door = ReadShort(Now + 0x02)
    Map = ReadShort(Now + 0x04)
    Btl = ReadShort(Now + 0x06)
    Evt = ReadShort(Now + 0x08)
    Cheats()
end

function _OnInit()
    if GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301 and ENGINE_TYPE == "ENGINE" then--PCSX2
        Platform = 'PS2'
        Now = 0x032BAE0 --Current Location
        Save = 0x032BB30 --Save File
        Obj0 = 0x1C94100 --00objentry.bin
	Cntrl = 0x1D48DB8
        Sys3 = 0x1CCB300 --03system.bin
        Btl0 = 0x1CE5D80 --00battle.bin
        Slot1 = 0x1C6C750 --Unit Slot 1
    elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then--PC
        Platform = 'PC'
        Now = 0x0714DB8 - 0x56454E
        Save = 0x09A7070 - 0x56450E
        Obj0 = 0x2A22B90 - 0x56450E
	Cntrl = 0x2A148A8 - 0x56450E
        Sys3 = 0x2A59DB0 - 0x56450E
        Btl0 = 0x2A74840 - 0x56450E
        Slot1 = 0x2A20C58 - 0x56450E
    end
end

function Events(M,B,E) --Check for Map, Btl, and Evt
    return ((Map == M or not M) and (Btl == B or not B) and (Evt == E or not E))
end

function Cheats()
local DriveDepleterPointer = 0x2A20238 - 0x56454E
local _FoundArrayAnim
local animpointer=ReadLong(0x1B2512)+0x2A8
local _CurrAnimPointer = ReadShort(ReadLong(0x00AD4218-0x56454E) + 0x180, true)
local SoraCurrentSpeed = 0x00716A60-0x56454E
local soraGravityPointer=ReadLong(0x1B2512)+0x138
local TestAnimation
	for i = 1, 6 do
        if _CurrAnimPointer ~= KeepAccelerate[i] then
        _FoundArrayAnim = false
        end
	end
	for i = 1, 6 do 
        if _CurrAnimPointer == KeepAccelerate[i] then
        _FoundArrayAnim = true
		end
    end
--ReadByte(Now+0) ~= 0x0A

	if _CurrAnimPointer == 2 and RunTimer > 0 and ReadShort(0x6877DA) == 0 then
	RunTimer = RunTimer - 1
	end
	if RunTimer == 0 and _FoundArrayAnim == true then
		if ReadShort(Now+0) == 0x0E07 or ReadShort(Now+0) == 0x0507 then
			if ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) < 60 then
			WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) + 0.25, true)
			end
		elseif ReadByte(Now+0) == 0x0A then
			if ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) < 54 then
			WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) + 0.25, true)
			end
		elseif ReadByte(Save+0x3524) == 1 or ReadByte(Save+0x3524) == 2 then
			if ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) < 36 then
			WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) + 0.25, true)
			end
		elseif ReadByte(Save+0x3524) == 4 then
			if ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) < 30 then
			WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) + 0.25, true)
			end
		elseif ReadByte(Save+0x3524) == 5 then
			if ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) < 48 then
			WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) + 0.25, true)
			end
		elseif ReadByte(Save+0x3524) == 6 then
			if ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) < 54 then
			WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) + 0.25, true)
			end
		elseif ReadByte(Save+0x3524) == 0 or ReadByte(Save+0x3524) == 3 then
			if ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) < 24 then
			WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, ReadFloat(ReadLong(SoraCurrentSpeed)+0x12C, true) + 0.25, true)
			end
		end
	elseif _CurrAnimPointer ~= 2 then
		if ReadShort(Now+0) == 0x0E07 or ReadShort(Now+0) == 0x0507 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 20, true)
		elseif ReadByte(Now+0) == 0x0A then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 18, true)
		elseif ReadByte(Save+0x3524) == 1 or ReadByte(Save+0x3524) == 2 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 12, true)
		elseif ReadByte(Save+0x3524) == 4 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 10, true)
		elseif ReadByte(Save+0x3524) == 5 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 16, true)
		elseif ReadByte(Save+0x3524) == 6 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 18, true)
		elseif ReadByte(Save+0x3524) == 0 or ReadByte(Save+0x3524) == 3 then
		WriteFloat(ReadLong(SoraCurrentSpeed)+0x12C, 8, true)
		end
		if RunTimer < 120 and ReadByte(Cntrl) == 0 and ReadShort(0x6877DA) == 0 then
		RunTimer = RunTimer + 1
		end
	end

	if ReadByte(0x24AA5B6) == 0 then
	WriteFloat(ReadLong(DriveDepleterPointer) + 0xE6C, 0, true)
	else WriteFloat(ReadLong(DriveDepleterPointer) + 0xE6C, 1, true)
	end

	if Done == 0 then
	WriteFloat(0x47435D - 0x56454E, 1.25)
	Done = 1
	end
	
	if _CurrAnimPointer == 183 and ReadByte(Save+0x3524) == 1 then
	Valor = Valor - 1
		if Valor == 0 then
		WriteFloat(animpointer, 2, true)
		end
	else 
	Valor = 30
	WriteFloat(animpointer, 1, true)
	end

WriteFloat(0x250D326, 1) --QR1 Acceleration
WriteFloat(0x250D32A, 0.98) --QR1 Deceleration
WriteFloat(0x250D36A, 1) --QR2 Acceleration
WriteFloat(0x250D36E, 0.98) --QR2 Deceleration
WriteFloat(0x250D3AE, 1) --QR3 Acceleration
WriteFloat(0x250D3B2, 0.98) --QR3 Deceleration
WriteFloat(0x250D3F2, 1) --QR4 Acceleration
WriteFloat(0x250D3F6, 0.98) --QR4 Deceleration
WriteFloat(0x250D436, 1) --AX2 QR Acceleration
WriteFloat(0x250D43A, 0.98) --AX2 QR Deceleration
WriteFloat(Sys3+0x17A9C, -0.00001)
WriteFloat(Sys3+0x17AA8, -0.00001)
WriteFloat(Sys3+0x17A94, -0.00001)
WriteFloat(Sys3+0x17B60, -0.00001)
WriteFloat(Sys3+0x17ADC, -0.00001)
WriteFloat(Sys3+0x17AD8, -0.00001)
WriteFloat(Sys3+0x1DE18, -0.00001)
WriteFloat(Sys3+0x17AEC, -0.00001)
WriteFloat(Sys3+0x17B1C, -0.00001)
WriteFloat(Sys3+0x1DEA8, -0.00001)
WriteFloat(Sys3+0x17B30, -0.00001)
WriteFloat(Sys3+0x17B20, -0.00001)
WriteFloat(Sys3+0x17780, -0.00001)
WriteFloat(Sys3+0x17B74, -0.00001)
WriteFloat(Sys3+0x17B64, -0.00001)
WriteFloat(Sys3+0x17AA0, 0)
WriteFloat(Sys3+0x17AE4, 0)
WriteFloat(Sys3+0x17B28, 0)
WriteFloat(Sys3+0x17B6C, 0)
WriteFloat(Sys3+0x17BB0, 0)
--Glide Turn Speeds: Default is 0.05235987902
WriteFloat(Sys3+0x17AAC, 1)
WriteFloat(Sys3+0x17AF0, 1)
WriteFloat(Sys3+0x17B34, 1)
WriteFloat(Sys3+0x17B78, 1)
WriteFloat(Sys3+0x17BBC, 1)
WriteFloat(soraGravityPointer, 10000, true)
end
