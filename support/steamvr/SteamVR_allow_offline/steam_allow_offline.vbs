Const ForReading = 1
Const ForWriting = 2

Dim RegX
Set RegX = NEW RegExp

strFileName = "C:\Program Files (x86)\Steam\config\loginusers.vdf"
strOldText = """SkipOfflineModeWarning""\s*""0"""
strNewText = """SkipOfflineModeWarning""	""1"""

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(strFileName, ForReading)

strText = objFile.ReadAll
objFile.Close
'strNewText = Replace(strText, strOldText, strNewText)
RegX.Pattern = strOldText
RegX.Global = True
strNewText = RegX.Replace(strText, strNewText)

Set objFile = objFSO.OpenTextFile(strFileName, ForWriting)
objFile.Write strNewText
objFile.Close
