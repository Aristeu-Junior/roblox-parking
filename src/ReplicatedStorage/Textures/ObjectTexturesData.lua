-- ObjectTexturesData.lua
-- 12 texturas de objetos e obstaculos de pista do Dr. Parking 4,
-- aprimoradas via GIMP GEGL e calibradas em escala 3D pelo Blender 5.3.

local ObjectTexturesData = {}

ObjectTexturesData.barrier = {
	Id = "barrier",
	Name = "Obj: barrier",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/barrier.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/barrier.jpg",
	ObjPath = "drparking4_texturas/assets/objects/barrier.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/barrier_s.obj",
	SourceSize = Vector2.new(256, 256),
	BBoxSize = Vector3.new(2.0000, 1.1487, 0.3000),
	AssetId = "",
	Material = Enum.Material.Metal,
	PBR = { Albedo = "textures_enhanced/assets/pbr/packed_barrier/barrier_albedo.png", Normal = "textures_enhanced/assets/pbr/packed_barrier/barrier_normal.png", Roughness = "textures_enhanced/assets/pbr/packed_barrier/barrier_roughness.png" },
	Palette = { Primary = Color3.fromRGB(200, 23, 0), Secondary = Color3.fromRGB(216, 77, 36) },
	PixelData = "36,36,CC1C02,CD1901,D02003,D42F03,D22903,CD1900,C91800,C01401,CB1A01,BD1200,BA1201,A10E03,C11300,B00C04,940101,9E0302,BD1808,CD1801,D8491D,D33711,D94F26,D94E27,D84C23,DC5228,E05B33,DA4E24,D94E24,D94E25,D43D1E,C53116,D84E26,A70000,AA0000,AC0201,AC0000,B90500,C11E08,B40700,BC0B00,D01B01,5E0703,AE0502,C81300,AA0201,AA0001,CE1901,EA7A53,EB8157,E87550,E56947,E36141,E46444|ABBC4D5E3DE5DE5DEE6DBFGCEHGIG8IGGHGG10IGHGEBFGCCJK11LKHH12LHHCBFGCCMN11ONMH12OJHEBFGCCMN11PNHHL11PHHEBFGCCJH11Q3H12QHHCIRGCCJ12MH14MHMCSTDTSD29TSUVWXYS4ZWZZWXXZa4ZWXXZa6ZWUYbbWYYWU5bWXcdeU3bWXcdeZ6baVYbbWYYWU4bWXcfgQXbbWXchiQU6baXYbbWXYWU4bWXd3jebbWXd3jWU5baVYbbWXYWU5bUWdQcX3bUbdQcX6baUYbbWXYWU6bU3Xa4bZ3Xa6baUYZbWYYW4UVUUVbbe5UVebe4UVUUVXYXUSZX30SXE3CkK4J4K11J5K5Jk3RIK4lj4mj10lj4m5lJ3nCHl3mN4oN4m5lmP3oOj4lK3mKNhpplO4oOl3p5Jq5oK4JHr3fi5g4jisgghF4nt5nt3ntnrggpLN4g4f4ghGt5FIGGI4FRAlsgNOLi6g3igghGt14FAofgNOLi5gh3fighGt14FAoOipNp5gir3OhghGt14FAoOihNp5gir3OhghGt14FAoOiNLLi5gh3PhghGt14FApigNOLi6g3igghGt14FApggNQN7h3rhhpI15nArsgfg13fg17qlpll15d17cA3tuvw4uw7u15wuvBBFRwx29yuBBFRwxy28zvBBnCuw29xvAADDvvu26vuvv",
}

ObjectTexturesData.box = {
	Id = "box",
	Name = "Obj: box",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/box.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/box.jpg",
	ObjPath = "drparking4_texturas/assets/objects/box.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/box_s.obj",
	SourceSize = Vector2.new(512, 512),
	BBoxSize = Vector3.new(2.0000, 0.8000, 0.5000),
	AssetId = "",
	Material = Enum.Material.Plastic,
	PBR = { Albedo = "textures_enhanced/assets/pbr/packed_box/box_albedo.png", Normal = "textures_enhanced/assets/pbr/packed_box/box_normal.png", Roughness = "textures_enhanced/assets/pbr/packed_box/box_roughness.png" },
	Palette = { Primary = Color3.fromRGB(123, 114, 117), Secondary = Color3.fromRGB(1, 1, 1) },
	PixelData = "36,36,C99805,EDB40A,201B0B,D6AD08,736D77,7E7475,7C7376,7B7275,82797B,837B7F,AB8E26,F7C403,413410,0B0A0A,44403F,2D240C,15120C,7F7678,857B80,8D8289,8D8288,7C7375,5C554C,040302,857B7B,8C8187,7A7175,000000,7A7277,7D7376,777077,554315,000006,FECB01,000002,9E7D1B,7D7477,7C7275,8C6906,715300,6F6A72,FCCF02,6F5617,917427,7B7171,7A7379,564A31,726B6F,696468,6D6766,7C7377,6C6669|ABCCBDEFGHI5JIHGFEKLMNDAOJH6GAPQDDCERGHST3UTSHGVRCALPQAWIH6GXQBDXPYHGHJU3ZUSHGaYMbALPbWJa6GCDDNPBFcdHJU3ZUSHGVeBfgALPOSa6GADNPLAEFGHJU3ZUSHGFEKhfiADOJH6GjQPLANekGHJU3ZUSHGlIQmhMXmWIH6GiPLAbPYaGHJU3ZUSHGaYfbjhfbOJa6GMLAgMBFHdHJU3ZUSHGVeBngjhMOSa6GDAiMhAoFGHJU3ZUSHGFEjhfijDOJH6GmXMhjNekGHJU3ZUSHGHIQmpfgnWIH6GbMhAbfYadHJU3ZUSHGaIqbmhfbOJa6GMLAgnBVHdHJU3ZUSHGFEBmgmpfOSa6GDAifhjoRGHJU3ZUSHGFErhnijBOJH6GmifhmgakGHJU3ZUSHGHINnpngnWIH6GifhmbfYadHJU3ZUSHGHIqbnpnbOSa6GnhminLVHdHJU3ZUSHGFEBminpnOSa6GDjinhjoRGHJU3ZUSHGFErhmbmDOJH6GninpmgVkGHJU3ZUSHGHYNnpmifWJH6GinpmbqYadHJU3ZUSHGHIrbnhmbOSa6GnhmimLaGdHJU3ZUSHGFEBjinpnOSa6GDmimhqoFGHJU3ZUSHGFeqLjinDOJH6GfimpngFdGHJU3ZUSHGHYNMhjgMWJH6GimpnbmYadHJU3ZUSHGHRrbMhjbOYsHaaHHGmhngmLeGdHJU3ZUSHGFEBAgMpmOUIIJSJIdAnbjhqoRGHJT3ZTSHGFtfBAXfAMOOu3OWcfQqDqQVGke8vkHIPfDqQfQXAAQQDKweIkoEIGGkv7wvkGGIeotItMALPCLDOoFlVFFHGGkvw3xwxxvkGGHFFVFEDLCCLDXPs8Gyovvwwvzwvk6GVtKCCpDgMKw7GHRsWWrsOWrvy6GHYQPpAXMpKw7GcYMXApMNDDxkV5GVROKKOOKKWz7GRENApPNDDCwIH6Gkswwvvwwvx7GkoDLCQBDNCstV6Gkv3xw3xz7GcRDCCLDNPBseV6Gkvw7z7GcRQCBANPLAwRV6Gkvw7z7GkaCMfPQffPwRH6Gkvw7z",
}

ObjectTexturesData.cone = {
	Id = "cone",
	Name = "Obj: cone",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/cone.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/cone.jpg",
	ObjPath = "drparking4_texturas/assets/objects/cone.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/cone_s.obj",
	SourceSize = Vector2.new(256, 256),
	BBoxSize = Vector3.new(0.6288, 1.0524, 0.6288),
	AssetId = "",
	Material = Enum.Material.Plastic,
	PBR = { Albedo = "textures_enhanced/assets/pbr/packed_cone/cone_albedo.png", Normal = "textures_enhanced/assets/pbr/packed_cone/cone_normal.png", Roughness = "textures_enhanced/assets/pbr/packed_cone/cone_roughness.png" },
	Palette = { Primary = Color3.fromRGB(218, 51, 0), Secondary = Color3.fromRGB(1, 0, 0) },
	PixelData = "36,36,DA3401,DB3401,DA3301,DA3500,E13D02,E74E06,DA3200,DA3300,DA3400,E03501,BF7B6F,EC7423,D72E01,DB3400,DB3503,C24628,C3B8B5,D4E0E2,D93000,D72A01,DC2901,DB3001,DE3200,D62601,D62200,D41D00,D01201,D11900,CA0000,D51A00,C60001,C10000,AE0000,B60100,CA0601,BC0000,AB0000,D93201,C92A01,960502,7C250F,000002,000000,030101,030000,24110A,20100A,8E3419,26140D,0B0706,24130B,24110B|A20BCBDDEEFFE4FCABG14HIIHGCBJEEFKE5FLFMBH11IDDIHGHNOJEJPQRLFFELFLLOBH5IGGSSGNGMTTMSCU3OVQRQWE3FLFEBH4IG5SXYYXXTMUPQPEFLRRKEFEFFEEBH4IGSTXZabZY3XMYPRQJEUKRRKJJ3FEBH3IHSTYaccabZYYXXMdQRPUEUQRRQKL3EBH3IGSTa3ecabZZYXXYPQQPVOFK4RQKJBH3IHSXfgheeiabZZYYTdPQQOEFUPQ3RQWBH3IHSXjkkhecibddZZYTdKRQPYEWUL3KOBH3IHSTakkgfecabb3ZYXdKRQPUUEFVWJOBH4ISTbgkkhfecabbdZZYXdKQQKPFJUJJDBH4ISMYikkgjfcia3bdZYXdPKQRRQKKPOBHIHGHGSXahkkhfecia3bdZYXYdPKQR3QOBHIlSSGSMZigkkhfecia3bdZZXXYdX4POBGl5SMXdi3kjfecia3bdZZYXMTX3UBlSl7MTZfkkgjfeciaa3bZZYXXTMMlCJJGMM3m3MSYigkgjfeciaa3bdZYYXXTMGnomm6n4mkkggjfeciia3bdZ3YXTSpq3r6srsrrnhgghjfeciaabbdZZYYXMs4qpr3p4qstt3khjfecciaabdZZYYTrquvv5w4uxppngkkghjfeciiaab3ZXrqwKwuututtwywxqrmf4kghjeecciiabbYrqwwxwztz4tyxqsmUjg4kghjfee3cidrqww9tyxqsmJajhg5kghhjjfeirquw9twxqsmGafjh3g9kirqxw9tyuqsmTbiefj4hg5kgfrqxw9tyuqsnMTZaceff4j3hjfirqxy9tyuqsmSSMTZaiic7ecarqxy9twwqrmSlSSMTXYZdbb4abXrqxy6tzwuwwqrmGHIlG3S5M3TMSrqxy6tuuxKoqrmWH3IH5G6SGrqr5uy3wvKwqrmJH10IH3IHBsqq5pr5xrqrmW15IHBs16qomN14HGBr7s7rqrmJA15BO",
}

ObjectTexturesData.display = {
	Id = "display",
	Name = "Obj: display",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/display.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/display.jpg",
	ObjPath = "drparking4_texturas/assets/objects/display.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/display_s.obj",
	SourceSize = Vector2.new(512, 256),
	BBoxSize = Vector3.new(6.0000, 3.5096, 0.3000),
	AssetId = "",
	Material = Enum.Material.SmoothPlastic,
	PBR = nil,
	Palette = { Primary = Color3.fromRGB(1, 1, 1), Secondary = Color3.fromRGB(253, 253, 253) },
	PixelData = "36,36,020202,030303,010101,000000,0C0C0C,0F0F0F,131313,151515,080808,040404,A3A3A3,E0DFDC,5D5D5D,CDCECD,FFFFFF,616161,C9C9C9,FEFEFE,FCFCFC,FEFDFC,FBFDFE,FDFDFD,FFFFFE,FEFFFF,EAE3D7,CEE5F3,F3F6F4,FFFEFC,FEFEFF,F1BF56,F9A706,4DB6ED,B1DDF4,029BE9,FAAD07,85BACF,04A2EC,018FDE,FCFEFF,E6D6BB,5D8892,9E9E98,D9A134,FFFEFE,C4C4BE,4B4B4B,191919,1C1C1C,212121,252525,242424,232323|3A24B8ABC34D3CEFF3G14HGG3FI7DCDJK24LMDA5DCDJN24OPDB5DCDJQRS4R3TUURV3UV5RSRPDB5DCDJQOV4OW10OX4OSOPDB5DCDJQOVOOWOXYYZZOa3ZUOX3OSOPDB5DCDJQOVOObcdeePfOg3hfaXXOOSOPDB5DCDJQOVObOYeeiejOgkllhfOmOOSOPDB5DCDJQOVObOniooipOghffhkUOXOSOPDB5DCDJQOVObOnePoojOghjOfkaOmOSOPDB5DCDJQOVObOneiiofOghfmfhZOmOSOPDB5DCDJQOVOWWSqeieKOghfOfhZOmOSOPDB5DCDBQOVOObOUdeedmghfmfhZOmOSOPDB5DCDBQOSOWXndXnedOghfOfhZOmOSOMDB5DCDAQOSObXdeYaeqgfhfZkkaOcOSOMDB5DCCAQOSObOneddiPhkklhkfXmOOSOMDB5D3CQOSOrWa4elhkllkhgOmOOSOMDB5DCCDQOSOOWOYddo3foffgWc3OSOMDB5DCCDQOS3OWOXLLNYLLNYOR4OSOMDB5DCCDQOS4ObSNsQNLQQLmR4OSOMDB5DCCDQOS20OSOMDB5DCADQOS7ORRORORR6OSOMDB5DCADs24SMDB5DCADN24OMDB5D3CoKp20KpKtDA5DCDBACIIFG3u5vuvvuuHFEIBDJ7D3C4I18E3IJ7DCC34DCA3C21A4C6DC29wJ5DC28xyJ5DC28yzJ5DC28yzJ5DC28xyIAADCAB",
}

ObjectTexturesData.display01 = {
	Id = "display01",
	Name = "Obj: display01",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/display01.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/display01.jpg",
	ObjPath = "drparking4_texturas/assets/objects/display.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/display_s.obj",
	SourceSize = Vector2.new(512, 256),
	BBoxSize = Vector3.new(6.0000, 3.5096, 0.3000),
	AssetId = "",
	Material = Enum.Material.SmoothPlastic,
	PBR = nil,
	Palette = { Primary = Color3.fromRGB(1, 1, 1), Secondary = Color3.fromRGB(36, 36, 36) },
	PixelData = "36,36,020202,030303,010101,000000,040404,050505,070707,080808,0B0B0A,0E0C0C,0F0F0F,0E0E0F,111010,010103,000002,090A0A,1E221E,242424,2E2C2C,212121,131513,181A18,060607,3B342B,5F5658,3E3C2A,B8B1B2,867F89,58707C,2A1A10,121212,232322,38463C,242017,25251E,232A27,303322,252525,A98364,020205,010000,7B3012,AC4F1C,030507,1F1614,5E1A07,010304,000202,010100,150605,22211F,020101|35ABC34DCCAEBEFGHIIJIJKLMMKJKKJJHNBOE7DCDPQR5STUVUPMFDPUWWKKXYZZVN6DCOEYaabaabaaccUdeSGfGCHeY3bR7DCDFgbccbbYbacchhHeISJFCfVfQiVN6DCDPSggYgSScYjjkUDFPSeWAHl3DeB6DCDFY4bcYabIekIBMJSeHAHlMACeB6DCOFYbm4bacDUknEKITVHBEDIWDeB6DCoPp4qbbacDhiOGMFgSBJWVTWDMB6DCorp4qmbaYDkhDHLLMLIeMlSUAMB6DCDIsdsdqmaagAksDPLHlXHHUXgSPMB6DCDPtpptqYbbSIkKDJKHSYWMFGPWIeB6DCCuYammqgbbLdkHDJJLUVMQWEMFveA6DCwBYaabYXbYGkkNwPJPeUUHxuDCxKB6DCDFYbbYXXbgVkiDBpqqtgVHqdgdqyC6DCDWSYgextYSkkhDx3qpclPdsgsdTo6DCDIIFzDxqSgkkUDd3ptZRIn3DOLA6DCDIGDDOxtUghkJDy3cYMVJoDCzFLA6DCDIIoxEdteXkkEDxlXXhsQJWECDCLA6DCwFX4pxPhkkDCx3DzsUMIPBACJA6DCCBZbtqYxLhkhDCt4pXYPJIEoCJA6DCCBSYttSxQkksDCt4qXbJIHnNoIA6DCordt3dxTkkMDDY4aZbVrdqgcUzO5DCzntqppqxhkkHCCbaYbaYgyWdmgcjov5DCoEx3dtxhkioDDX4YyueFdqccQov5DCDEnNnnrHUMeHPPENFEvWPHWJZgjGC6DCCBKUVyl15SlTUxxP7D3CEEFWWG14H3GrrB7DCC34DCA3C21A4C6DC29TE5DC28lRE5DC28RfE5DC28RfE5DC28lRWAADCAB",
}

ObjectTexturesData.display02 = {
	Id = "display02",
	Name = "Obj: display02",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/display02.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/display02.jpg",
	ObjPath = "drparking4_texturas/assets/objects/display.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/display_s.obj",
	SourceSize = Vector2.new(512, 256),
	BBoxSize = Vector3.new(6.0000, 3.5096, 0.3000),
	AssetId = "",
	Material = Enum.Material.SmoothPlastic,
	PBR = nil,
	Palette = { Primary = Color3.fromRGB(1, 1, 1), Secondary = Color3.fromRGB(36, 36, 35) },
	PixelData = "36,36,020202,030303,010101,000000,010100,201C19,202123,171615,252525,26252A,232526,212122,0B0E10,000001,8F8169,8F734D,95A676,AB925B,4B463B,555C4C,686152,7E705D,9B7443,CD922B,A98446,795C40,654D32,352F26,2F210F,B8B198,7A6750,7F7C5F,1A0000,915C29,926636,3F4332,DCDACB,CFB06E,090605,9C6633,242424,657A45,262924,698114,7A9045,020201,1E250B,000102,010302,020203,262429,020506|AA25B8ABC34DCCEF3GH3GI4GJKFLLGLLFGILMDN5DCDMOPPOQPRPS3PQTTOO3UVOVSVTDA5DCDMWXXYRXYZa3XPbcdOaefSTagUTDA5DCDMWXXaFRhSdiXXRdOdOQOdjJacOTDA5DCDMWXXYcfklUbXXYdOHUSfkSFfVfSDA5DCDMW3XdRdklYXXYkVmOdTOSKUUjjDC5DCDMWXSidbnRXajXWOUHQkjcUbUTbSDC5DCDMYXbHYPXkdZmhRoVbddbbdVjScSDC5DCDMWXknlkaRdjQXPbdQOdHjkVgSOSDC5DCDMOlRXRfcHaadXPJddeOUbkOcZQTDA5DCDmdlXlWHZZMSlXPSdQdQdbaecVdSDA5DCDMP4XaUkXVdXYUeeOOkegVefOjDC5DCDMQY4ROOQdPPdQfOVfdfUOOUTUDA5DCDMVZZaaZeeOZZeO3pqJLbj3pOTDA5DCDMZ5hWWOWhnerrsQjDEBcjssSDt5DCDMe4h3iPinnVrrQkQfuDNubrSDt5DCDMe4hinihhnnPrrQ3kQpHvDaSDt5DCDMeWihhi6nPrrsQdkkdujDaTDA5DCDMe3PhhinnRinVrrkdsQkVBrbsSDA5DCDMehPPhWihnPnnerrkdrrQSDrsrSDt5DCDMe4hPPnhhnnPrrdQrjmrussrSDt5DCDMZhRhhPWhWninP4rsuNrsYpQSDw5DCDMZnVWWhinPWnhe5rbusrXpTTDw5DCDMZhPii3hiinhV9rXfQTDw5DCDmVUUVVUVeUUeUOV4UfUUeeTfSDx5DCCAMHFFGJK5JI5JyJyGHHMm7D3C3B20mzzB7DCC34DCA3C21A4C6DC29LB5DC28IoB5DC29oB5DC29oB5DC28IomAADCAB",
}

ObjectTexturesData.fence = {
	Id = "fence",
	Name = "Obj: fence",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/fence.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/fence.jpg",
	ObjPath = "drparking4_texturas/assets/objects/fence.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/fence_s.obj",
	SourceSize = Vector2.new(512, 256),
	BBoxSize = Vector3.new(2.0000, 1.0843, 0.1200),
	AssetId = "",
	Material = Enum.Material.Metal,
	PBR = { Albedo = "textures_enhanced/assets/pbr/packed_fence/fence_albedo.png", Normal = "textures_enhanced/assets/pbr/packed_fence/fence_normal.png", Roughness = "textures_enhanced/assets/pbr/packed_fence/fence_roughness.png" },
	Palette = { Primary = Color3.fromRGB(0, 0, 0), Secondary = Color3.fromRGB(101, 101, 101) },
	PixelData = "36,36,000000,010100,010000,000001,030201,0B0804,B08002,DAA502,81680E,010101,181202,694910,281902,342402,392D0F,865302,F8AA01,F8B801,FFC700,976B03,DC8A03,020100,000100,222118,25282C,393525,4A4A4A,4F4F4F,545454,565656,595959,5D5D5D,616060,646464,656565,676767,6A6A69,5F5F5F,616161,6D6D6D,707070,737373,808080,494949,4D4D4D,606060,515151,0E0E0E|147ABCAABBCAABBCAABBCAABBCAABB10ADAECADAECDDAEADDAEADDAEAADDE5ABAFGHIJKGHICKGHLAMGHLANGHLAOHHOAE3ABAFPIOCKIIOBMIINBMIINCNIIMAOIPKAB3AEALQQOALRRNDISRNDTSHMATSHKAGRUFBC3AVEURGDFHSGDKHSTDMRSIDNRSLAOQQLAE5ALQQOALRRNDISRMDTSHKAGSHFBGRUEVC4AFGRGJFHSGDKHSTDMRSIDNRSLAOQQLAE5ANQQOALRQNDISRMDTSHKDGSHFJGRUEFNAB3AMQGDFURGDKHSTDMRSIDNRSLAOQQLALPAE3AMUOALQQNAISQMDTSHKAGSHFBGRUEEULAE3ANTWFUQTDKURTDMQRPDNQRLANQQLAOULAE3ANNJLUUMEPQUMETQUKETQUFEGQGEFGUL5E3APGLAETGLAFGGLAKGGOAMTGNAMTTM5AXXYXX26Y5Zabbcdeefghijj3kjeflmmhjknoo5p3q3rssbcc3ef5lefltmijknoo6pqoraasbucdeeflt3mthjjkno3p9qpraasbucdeeflt3mleflmhijknoo5pqqpraasbucdeeflt3mlccdeeftmijkknoonpqpraasbucdeeflt3mlccdeeflmhjjk4nopjraasbucdeeflt3mlddeeflmhjkkn5opiraasbucdeeflt3mtthhjkkno3p5qppiraasbucdeeflt3mtmhijkno3p6qppiraasbucdeeflt3mldeeflthijknno3popiraasbucdeeflt3mlccdeeftmijkkn4opirrassucceefll3tldeefftmhjkknn5oh5F31v36A36J72A",
}

ObjectTexturesData.grass = {
	Id = "grass",
	Name = "Obj: grass",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/grass.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/grass.jpg",
	ObjPath = "drparking4_texturas/assets/objects/grass.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/grass_s.obj",
	SourceSize = Vector2.new(1024, 512),
	BBoxSize = Vector3.new(1.6000, 0.4500, 6.0000),
	AssetId = "",
	Material = Enum.Material.Grass,
	PBR = { Albedo = "textures_enhanced/assets/pbr/packed_grass/grass_albedo.png", Normal = "textures_enhanced/assets/pbr/packed_grass/grass_normal.png", Roughness = "textures_enhanced/assets/pbr/packed_grass/grass_roughness.png" },
	Palette = { Primary = Color3.fromRGB(0, 0, 0), Secondary = Color3.fromRGB(211, 134, 0) },
	PixelData = "36,36,1E1303,030200,0E0A04,C57903,B87205,010100,3B2502,E18B00,825206,573E15,EB9501,D88300,975F02,E38F01,6E4401,C2800B,000000,CB7600,D98B01,D68901,7C6C58,81725B,948471,816E54,7C6644,887866,86735B,8D7D64,746539,CC8301,887856,827148,696200,6B6501,6D6701,6F6801,6E6701,6C6601,716A01,706900,6F6800,706901,7C6C31,010001,726B01,756D01,000001,D48700,D48800|3ABCDEFGHIFJKJFIHAFEDBALMFGNOFILDLP4QBREQANIQJKJQIHAQERQCLMQGKOQIHDLPFFCCAPECGSICJNJCISGCEPCATMCGNOCISPLPFQJUVWXYZaYabXVaUXaZaacYZYUUXZXYWYdPFQJVUV3UVY3UaUVYXZU3Y3UVUaXYVcREFQcXWWXXZWWXaWWXbWXZeebWabWbXWbfZfREBFJXbeXYXeXfYXbYXbXXffXafYeXVbXfZcREQQcZfghijikkillhghgglikggilhhlgeWYLEAAcZfhlmnjnnonnhhkhllhmhkknlkplfWYEMRReWfhhppipjikllgi4hjiklpkilgqaUBCRRYVqgjpnkiikokhhollhkoljiolikgqZcBCRRfWqghpklolkiikhhjkhioliklholgfWYrCRRqWYggiilnjjiihhojkkhloiilhphhfZcFCRRqZfghijhjjomiihnm3khijkkjmhgqacQCRRYZeglkppmmjlhmppjmsskljjlkmjgfZcFCRRfUYgkppossjhkp3msttpmpmpmmpgfWcBCRRfUqhkjt4sjjij6tsmmjmsphqWYBCAAcZfmsmtm4tmnm8tststskqZYEMuQJWemtmtm3tstpst3s3tnsttstpfZYREFFJaXfaWeVbbf3bfeWfaXXbWeXfWZXXWcREFQJZXebZXaZXaWWbfbWaZeaWbXZaWWVXWcREFQJ3ZVaVZUaaUZVVUaWVUfYVUVZUbbYZcREFQJYUWfcVeYUafYUYfYUeecceYYcfXcYWfvP3BQBdEQGNIQJKJFMNAQEdBASMQGKOQINdLP4QCDEQANIQJKJQIHAQEDFCLMQGKOQIHDLP3GBBDEQAHIQJKJQIHAQEDBCLMQGNOQILDLPHNSABDEQAHIQJKJQIHAQEDBCLMQGNOQILDSPvwdABDEQAHIQJNJQIHAQEDBCLMQGNOQOLDSPwTvABdEQGNIQJKJQINAQEDBASMQGKOQIHdTPwTvABdEQGKMQJKJQMKAQDdBAHMQGKOQINdTPwTvABdEBGKMBJKJBMKABDdBAHMBGKOBINdTPwTvCQdEQAKIQJKJQIKAQEdQCHMQGKOQINdTPwTvGGdDGJNMGOKOGMNJGDdGGSEGOKIGMNdTP3wSSwTHSvTHSvSHTwSHTwSSwTHSvSHTwdTP3wvvwwvvwwvvwvvwwvvwwvvwwvvwvvwwdTP33wdTP",
}

ObjectTexturesData.grasscircle = {
	Id = "grasscircle",
	Name = "Obj: grasscircle",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/grasscircle.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/grasscircle.jpg",
	ObjPath = "drparking4_texturas/assets/objects/grasscircle.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/grasscircle_s.obj",
	SourceSize = Vector2.new(512, 512),
	BBoxSize = Vector3.new(5.1410, 0.6500, 5.1410),
	AssetId = "",
	Material = Enum.Material.Grass,
	PBR = nil,
	Palette = { Primary = Color3.fromRGB(88, 103, 0), Secondary = Color3.fromRGB(122, 107, 90) },
	PixelData = "36,36,6D624C,6C624B,776956,7C6B5C,7B6B5B,7A6B5A,786A59,796A59,796A5A,7C6C5B,8D7B65,86775D,84725D,827158,8B765F,94826E,706F29,7B6B5C,7C6E57,616C04,5B6800,5F6B00,616C01,616D01,6B6830,5A6801,5C6901,636F01,5D6A01,7D684C,5B6806,5A6A01,5E6C01,596801,576801,546501,5C6B01,576601,576701,7F6E55,556501,546403,516301,566701,6F634E,6D624B,5D540E,6D624D,6D634F,7B6B52,C0841C,0B0803|ABCD10EFGGHFIGHI10EI3ABCD7EIHFJKLKMNOMJJH8EI3ABCD5EDFFPPNPL3QLONPMHR6EI3ABCD4EIGSOLQTTUVWXVTTYKMCRD4EI3ABCD3EIJPKQZaXbWWXWWVUUTNPNC4EI3ABCD3EJKLQaWaXcVbXbVcaTVTQLPF3EI3ABCDEEGNdefXbWcgWXgbXWcVWghQPSIEEI3ABCDEIKKecZaWgaZgbbXcaaXXZaiQKJIEI3ABCJRHPQjTfagZakWgVkgblcgcZmlPKCJI3ABCJFndimffmkcXkcZZ4ghfZhhleOJII3ABCJHOejiljolfkfhhkfmfomfihjljdKHF3ABCIMLpjfhjjqiffhhkforjoirmjpjQOJI3ABGHKnqilmqjmmkiiffk3fjlrirqqePMGsAABCFKYqpjojriomrfhmifkqrrqrilqpLJG3AtCJPu3qoqoiojqmffiooqhill4qdMG4ACJPuqpjoqqilojmirfloqomol4qLPCsAABCJKQqmrijjiqfjlffkrmqrmihi3qLPCsAABGHOdqfkhiojiffmifirmqmfihjqqpNMGvAABGCPLqhif3ijiflkfkhlqorrirlqeKJHvAABCFMLehikihllffggkkofiffmfrajYKHI3ABCRJOefhlmaZfZfalmfaXkgaoZhcrYMHI3ABCJCPNlaZjgWgXhaZVXcaXVkZVkUQOSRH3ABCJHMPQfWccbXag4bXVZgXgXcTKPGJI3ABCDEGMPTgTXVcX5bgWgXbcThYKCREI3ABCDEDFKNTcbWVVWbbXXWacWbWgQPJ3EI3ABCDEERCNdQVVTcWX3bcaWWVTQOKGJEEI3ABCD3EDGMPdeaUW3bWWUaVTLKJH4EI3ABCD5EFLOdQeTVVWXbTQQNOJI5EI3ABCD6EHHMKPNdQddOPOKSHI6EI3AtGD7JDRJ3MKPOMMSFRD7JF3ABv3swssv5svvstv6sv6svBAtJJHCxdxSMSSNxSMLNSNSCSddSMSSNxS3MtwOLOPxdMPPnPMKKNOP3LPndNKPnPMKKMOPwdOSdnKNOJtdONMCddKKMdxLNKMttLNOFdsOdyy3zyyuzzuyyuzzuyyuzzuyy3z3y3z3yb3zyyuzzuyyuzzuyyuzzuyy3z3y3zyy",
}

ObjectTexturesData.grasssector = {
	Id = "grasssector",
	Name = "Obj: grasssector",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/grasssector.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/grasssector.jpg",
	ObjPath = "drparking4_texturas/assets/objects/grasssector.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/grasssector_s.obj",
	SourceSize = Vector2.new(512, 512),
	BBoxSize = Vector3.new(2.5000, 0.6500, 2.5000),
	AssetId = "",
	Material = Enum.Material.Grass,
	PBR = nil,
	Palette = { Primary = Color3.fromRGB(108, 98, 75), Secondary = Color3.fromRGB(88, 105, 0) },
	PixelData = "36,36,6D624C,6B614B,6A5F49,6D624D,6B604A,6B614A,6C614B,6E634D,766752,81715E,84745F,726044,796A54,746347,796C45,7D6E59,877863,8D7B66,796642,736650,93826E,816D54,6F5526,606C00,656F02,667101,667201,627001,646C0C,746752,626E02,6A710B,5E6D01,5B6C01,5F6E01,5C6A01,586901,5A6C01,596901,566701,596A01,546502,5F690A,6A6246,5B6A00,6D634D,1E170A,C1861E,B6790B,403017,020100|10ABCCDEFBEBCEGBA3CFFCCBBGG10AHIJKLMMNONJPMIIQJJILRQSSPME8AGTMKUSOM3SOV3SOVSOOVOWSMTB8AEIQWXYZYXZYXZZaZZXXbYbaacQdF8AGHJSZ3aZYZZaZaaYYZZ4acLL10AENOeeYYXebZ3abZbX5afR11ABNLfbZbgZYabXbbaaeebYebfKIF9AEIIchebiaeijjgbeiYjijkgcSN12ARSlegiibihjggjgmjgjmmcSLB9AHCROnihhiijkojgjohkhmpkqJPC9ADCNPphgogjhkpkgghgnknnlqPN11AGHJrkopmkjlmhkghphlgghqSLD12ATQco3noohoknpkhl3hqNMC12ACJMppnk3nkkm3pnsolqQIE12AGTUOpjpnkoonnppknjhhqUQC12AHCQUcklknmononpkl3hpRRC13AHCJTmhnhjhhnkpknmolqPIF15AHPrhgjmjokos3hkhmQdF14AHCMQLqpnjmgiibimkgeTME16AHMSSWhbbjgaiibgbeSTG17AErMUOXbYgXbbZbbYSLB17AHAHNSJcXiYYaYeZYPAG20AEAJKSqib4aeKRC20ADACMKSSWcfcYXOQC22AHEENOSJVOROIPC25ABCEHNLQKMIG26AHA3GCCAG32AHHAtAAGGBBGA3GFFBAF3EGGFGBAGGAFBBAGEBEAHT3dTNdTH3IH3IMdT3dHTTH3INdIIMHHRQJKVOVUUJKQKRRUKQRJKJSVRUJKRKQRUREdJPRRNMJUUVUPRKOKUJPKUIOPRUMUPQQVVUTPUJVRUQUJTVRQQJPVUUQMJUQUQdTRKRJPIUPuWvw3xSvvWxxWvvWuxWvw3xvvw3xwvvxWyuwwuyyfwwxyyYwwxyyqvw3y3w3y3wypuxwwxuufwwxuufwwxuuWww3u3w3u3wuW",
}

ObjectTexturesData.grasstriangle = {
	Id = "grasstriangle",
	Name = "Obj: grasstriangle",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/grasstriangle.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/grasstriangle.jpg",
	ObjPath = "drparking4_texturas/assets/objects/grasstriangle.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/grasstriangle_s.obj",
	SourceSize = Vector2.new(512, 512),
	BBoxSize = Vector3.new(2.5000, 0.6500, 2.5000),
	AssetId = "",
	Material = Enum.Material.Grass,
	PBR = nil,
	Palette = { Primary = Color3.fromRGB(108, 98, 75), Secondary = Color3.fromRGB(88, 105, 0) },
	PixelData = "36,36,6D624C,6B604A,6A5F49,6C614B,6B614A,6B614B,6D634D,6A5D45,786955,84755E,76603E,7B6C53,77654D,816C52,80715D,897A66,83725D,706345,8D7C69,796A46,6D624D,998569,77653C,7C6F52,746751,5B6B01,657103,5E6D02,606E01,5C6D01,636F03,596A01,5C6C01,626C06,877764,6C624C,586800,61661A,6D624B,6F634E,556601,5A6807,776851,6C5F48,251B0A,433216,BC8520,684A14,A97B2D,000000,CF8403,020201|10ABCCDBEFBFBBDFGCCBEEHEEFAD11AIJJKLIMNMOOIMMPQJIRSPTTLIB8AUBIJVWWT3WTT4WXWTWXTWWLYD9AGCYVTZabcdcZccZcdcebcfghiYB10AGEYNWbccaeabb3cbaccbchKRj11AGFYOTkgZbc3Z4cdgZglSmj12AGBnMTbkbZfZZcffgZcdolQYE13AUjHQPpZgZdkZooZdZdZpTRj15AGHPXpffgffoofkofopTRF16ADmIWpfZkkoof4opQOC17AFRNWpZok3of3kpORj18AUHOXpkgoofodfopTRj19AjmMWpZdggfkokhMLC20AjHVSpZkdZffkpPqB21AUniXpdcggkfpViH22ABnTWhdZb3ZPSH23AjHLJhccZZpOYE25ArSJp3chiYE25ADmiSh3aMIB25AGCqVKhaaWMF26AGBHMJlaTRj28AGHLOlXnD29AGrOqJSH31ABKNQC31AUrMOC32AjnqD33Amm35AGAADDEDFjDDjEFFjFBEBDDEDEjDDjEFFjDBFBAG5YnYYnqYYmYqqI5YnYYnYYqmYIYInmPP3QTNSVOJPQPSViJS3QTNPVQQPQP3SrnQOiSMMOSVqSOPiLNSQOJVqMOPVNSOiiNNSYISiLiViSiYLSJPOLLVVSLOSPVPIYPJSOLqVOstuuvtsWuuvssvuuvstvuutstwuutstwuutsxsyytxxvyyvxxvyyvxxtyysxxwyysxxwyysxzsyytzzvyyvzzvyyvzzvyyszzwyyszzayysz",
}

ObjectTexturesData.sign = {
	Id = "sign",
	Name = "Obj: sign",
	Category = "objects",
	OriginalPath = "drparking4_texturas/assets/objects/sign.jpg",
	EnhancedPath = "textures_enhanced/assets/objects/sign.jpg",
	ObjPath = "drparking4_texturas/assets/objects/sign.obj",
	ShadowObjPath = "drparking4_texturas/assets/objects/sign_s.obj",
	SourceSize = Vector2.new(256, 256),
	BBoxSize = Vector3.new(0.8416, 1.0302, 0.5714),
	AssetId = "",
	Material = Enum.Material.Metal,
	PBR = nil,
	Palette = { Primary = Color3.fromRGB(242, 179, 0), Secondary = Color3.fromRGB(228, 135, 0) },
	PixelData = "36,36,F2B301,F1B301,F1B300,F2B700,F1B200,EB9F01,E37D00,E58500,F1B000,EA9800,E07405,E17701,F1A401,E89001,EA9901,E17801,E00B08,E60000,EB9A01,E12514,E04D34,E8CF87,CBA14C,F3A801,18130A,684C10,F8FBFB,F2B300,BC0404,ECA201,EFA900,F2B500,F0AD00,EC9E01,EFAB00,E58800,E58700,EFA700,EFA500,EDA300,B4710C,ECA000,DB870B,EB9C00|26A9BCA25C10DA10C4E8CEDFG9HA7CEIC4DEI6CEDJK8LKA6CECDDMNNMDDCE4CEDOK8PLA5CIDIKQ4RQKDDE3CEDOKP8LA4CIDSTRU4VURTMDECCEDOKP8LA3CEDSQRW7VQQXDECEDOKP8LA4CATRRT6YZVQTDECEDOKP8LACCIDKRVURQZ3VZYWVRHDEEDOKP8LACCEDQTaaURT3aVYYaQTDEEDOKP8LbCEDMRW3acRTaaVYYaURBCEDJKP8LBIIDNRV3aYcRTZYYVaURdDIDSKP8LEIIDORV3aYYcRcYWaaURMBIDJK9LIEIBeRU3aYYaURT3aUQBIIfSP9G3IgDTQ3aYYaaUcTaaQTDgIIA10fgIIgDHcWaaYY3aUcTUcNfggIh10J4giDTcVaYY4aUccKDiggIN10H6giTcUV5aUcTB3giINH9jg3igeIeTcQ4UccKIgegiegNHj7kj6ieiDNTQccQKODie3iegNHj7kj8elIDgllgDIl5eliNH8kj9lmn3AImm6lmeNH8kj11looZoXm7leNH8kjm7lnnX4YXnmm5leNH8kj6nmlXlM4o3Xmm4nlNH8kj5nmF12ZX4nmNH8kj5dMNYZ5YZ3YZ5dnNH8kj5pnOoq10ond3pnNH8kj6pdXM10XF4pdNH8kj7FrF10r5FdNH8kj7F8hFhFh6FNH8kj24rhN9kj24SrNH8kj25SNH8kj24OSNk9j",
}

return ObjectTexturesData