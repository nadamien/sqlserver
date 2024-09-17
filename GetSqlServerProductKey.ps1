function GetSqlServerProductKey($InstanceName="MSSQL14.PWEELKINS") {
    $localmachine = [Microsoft.Win32.RegistryHive]::LocalMachine
    $defaultview = [Microsoft.Win32.RegistryView]::Default
    $reg = [Microsoft.Win32.RegistryKey]::OpenBaseKey($localmachine, $defaultview)
    $key = "SOFTWARE\Microsoft\Microsoft SQL Server\$InstanceName\Setup"
    $encodedData = $reg.OpenSubKey($key).GetValue("DigitalProductID")
    $reg.Close()
 
    try {
        $binArray = ($encodedData)[0..66]
        $productKey = $null
 
        $charsArray = "B", "C", "D", "F", "G", "H", "J", "K", "M", "P", "Q", "R", "T", "V", "W", "X", "Y", "2", "3", "4", "6", "7", "8", "9"
 
        $isNKey = ([math]::truncate($binArray[14] / 0x6) -band 0x1) -ne 0;
        if ($isNKey) {
        $binArray[14] = $binArray[14] -band 0xF7
        }
 
        $last = 0
 
        for ($i = 24; $i -ge 0; $i--) {
            $k = 0
            for ($j = 14; $j -ge 0; $j--) {
                $k = $k * 256 -bxor $binArray[$j]
                $binArray[$j] = [math]::truncate($k / 24)
                $k = $k % 24
            }
            $productKey = $charsArray[$k] + $productKey
            $last = $k
        }
 
        if ($isNKey) {
            $part1 = $productKey.Substring(1, $last)
            $part2 = $productKey.Substring(1, $productKey.Length-1)
            if ($last -eq 0) {
                $productKey = "N" + $part2
            }
            else {
                $productKey = $part2.Insert($part2.IndexOf($part1) + $part1.Length, "N")
            }
        }
 
        $productKey = $productKey.Insert(20, "-").Insert(15, "-").Insert(10, "-").Insert(5, "-")
    } 
    catch {
        $productkey = "Cannot decode product key."
    }


    /*Run function GetSqlServerProductKey/*
 
    $productKey
}