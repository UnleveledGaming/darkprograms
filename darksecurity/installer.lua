term.clear()
term.setCursorPos(1, 1)
textutils.slowPrint("Checking if HTTP is enabled...")
  if http then
		print("HTTP is enabled!")
	else
		textutils.slowPrint("HTTP is not enabled.")
		textutils.slowPrint("Please enable it.")
		return exit
	end
sleep(0.5)
programs = {}

term.clear()
term.setCursorPos(1,1)
textutils.slowPrint("Please choose a program type.")
repeat
 print("")
	write("Server/Client: ")
	installAnswer = read()
until ((installAnswer == "Server") or (installAnswer == "Client") or (installAnswer == "server") or (installAnswer == "client"))
	
	if installAnswer == "Server" then
		table.insert(programs, "server")
	elseif installAnswer == "Client" then
		table.insert(programs, "client")
	elseif installAnswer == "server" then
		table.insert(programs, "server")
	elseif installAnswer == "client" then
		table.insert(programs, "client")
	end

	print("Where would you like to download them to?")
	print("Default is /")
 print("(Press Enter to Skip)")
	write("Path: ")
	pathAnswer = read()

	if pathAnswer == "" then
		pathAnswer = "/"
	end

	print("Downloading requested programs...")
	local status, getGit = pcall(http.get, "https://raw.github.com/darkrising/darkprograms/darkprograms/programVersions")
  if not status then
    print("\nFailed to get Program Versions file.")
    print("Error: ".. getGit)
    return exit
  end 
  
	local getGit = getGit.readAll()
	NVersion = textutils.unserialize(getGit)

	for i = 1, #programs do
		print("")
		write("Downloading: "..programs[i])
		getGit = http.get(NVersion[programs[i]].GitURL)
		getGit = getGit.readAll()
		local file = fs.open(pathAnswer..programs[i], "w")
		file.write(getGit)
		file.close()
		write(".. Done")
		sleep(1)
	end

	print("\nPrograms are now downloaded.")
	print("Would you like to generate a startup file?")
	repeat
		write("Y / N: ")
		startupAnswer = read()
	until ((startupAnswer == "Y") or (startupAnswer == "N") or (startupAnswer == "y") or (startupAnswer == "n"))

		if startupAnswer == "Y" then
			file = fs.open("startup", "w")
			file.write("shell.run(\"".. programs[1] .."\")")
		elseif startupAnswer == "y" then
			file = fs.open("startup", "w")
			file.write("shell.run(\"".. programs[1] .."\")")
		end

		print("\nDone!")
		print("Thanks for choosing DarkPrograms for all your programming needs!")
		print("")
  textutils.slowPrint("Computer will now restart...")
		sleep(1.5)
		os.reboot()
