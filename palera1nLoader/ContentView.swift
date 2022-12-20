//
//  ContentView.swift
//  palera1nLoader
//
//  Created by Lakhan Lothiyi on 11/11/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject var console = Console()
    
    @State var bounds: CGSize? = nil
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.init(hex: "071B33"), .init(hex: "833F46"), .init(hex: "FFB123")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                content
                    .onAppear {
                        self.bounds = geo.size
                        self.splashTimeout = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                            withAnimation(.spring()) {
                                splash = false
                            }
                            
                            let d = HostManager.self
                            let machinename = d.getModelName() ?? "Unknown"
                            let modelarch = d.getModelArchitecture() ?? "Unknown"
                            let platformname = d.getPlatformName() ?? "Unknown"
                            let platformver = d.getPlatformVersion() ?? "Unknown"
                            
                            console.log("Welcome to palera1n-High-Sierra loader")
                            console.log("    with Cydia and Zebra")
                            console.log("Kickstart is a new button that fixes")
                            console.log("    dpkg, apt, cydia substrate, and preferenceloader")
                            console.log(uname())
                            console.log("\(machinename) running \(platformname) \(platformver) (\(modelarch))")
                        }
                    }
            }
        }
        .environmentObject(console)
    }
    
    @State var splash = true
    @State var splashTimeout: Timer? = nil
    
    @ViewBuilder
    var content: some View {
        VStack {
            titlebar
                .padding(.top, 20)
            
            consoleview
                .opacity(splash ? 0 : 1)
                .frame(maxHeight: splash ? 0 : .infinity)
                .padding([.top, .horizontal])
                .padding(.bottom, 20)
            
            Spacer()
                .frame(maxHeight: !splash ? 0 : .infinity)
                .padding([.top, .horizontal])
                .padding(.bottom, 20)
            
            toolbar
        }
        .foregroundColor(.white)
        .padding()
        .padding(.bottom)
        .padding(.vertical, 20)
    }
    
    @ViewBuilder
    var titlebar: some View {
        VStack {
            HStack {
                Image("palera1n-white")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64)
                Text("palera1n")
                    .font(.system(size: 48, weight: .bold))
            }
            .padding(8)
        }
    }
    
    @ViewBuilder
    var consoleview: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scroll in
                    ForEach(0..<self.console.consoleData.count, id: \.self) { i in
                        let item = self.console.consoleData[i]
                        logItemView(item)
                            .padding(.bottom, 1)
                    }
                    .onChange(of: self.console.consoleData.count) { newValue in
                        scroll.scrollTo(self.console.consoleData.count - 1)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: splash ? 0 : ( bounds?.height ?? 1 / 1.9 ))
        .background(Color("CellBackground"))
        .cornerRadius(20)
        .padding(.bottom)
    }
    
    @ViewBuilder
    func logItemView(_ item: LogItem) -> some View {
        HStack {
            Text(item.string)
                .foregroundColor(Console.logTypeToColor(item.type))
                .font(.custom("Menlo", size: 12))
            Spacer()
        }
    }
    
    @ViewBuilder
    var toolbar: some View {
        ToolbarController {
            console.log("[*] Starting bootstrap process")
            strap()
        }
    }
    
    private func strap() -> Void {
        let tb = ToolbarStateMoment.s
        tb.toolbarState = .disabled
        
        guard let tar = Bundle.main.path(forResource: "bootstrap", ofType: "tar") else {
            let msg = "Failed to find bootstrap"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
         
        guard let helper = Bundle.main.path(forAuxiliaryExecutable: "palera1nHelper") else {
            let msg = "Could not find Helper"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let deb = Bundle.main.path(forResource: "sileo", ofType: "deb") else {
            let msg = "Could not find Sileo"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let zebra = Bundle.main.path(forResource: "zebra", ofType: "deb") else {
            let msg = "Could not find Zebra"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let libswift = Bundle.main.path(forResource: "libswift", ofType: "deb") else {
            let msg = "Could not find libswift deb"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let safemode = Bundle.main.path(forResource: "safemode", ofType: "deb") else {
            let msg = "Could not find safemode"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let preferenceloader = Bundle.main.path(forResource: "preferenceloader", ofType: "deb") else {
            let msg = "Could not find preferenceloader"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let substitute = Bundle.main.path(forResource: "substitute", ofType: "deb") else {
            let msg = "Could not find substitute"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let autosign = Bundle.main.path(forResource: "autosign", ofType: "deb") else {
            let msg = "Could not find autosign"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let libhooker = Bundle.main.path(forResource: "libhooker", ofType: "deb") else {
            let msg = "Could not find libhooker"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let rocketbootstrap = Bundle.main.path(forResource: "rocketbootstrap", ofType: "deb") else {
            let msg = "Could not find rocketbootstrap"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let cephei = Bundle.main.path(forResource: "cephei", ofType: "deb") else {
            let msg = "Could not find cephei"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let altlist = Bundle.main.path(forResource: "altlist", ofType: "deb") else {
            let msg = "Could not find altlist"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let choicy = Bundle.main.path(forResource: "choicy", ofType: "deb") else {
            let msg = "Could not find choicy"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let ldid = Bundle.main.path(forResource: "ldid", ofType: "deb") else {
            let msg = "Could not find ldid"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let sudo = Bundle.main.path(forResource: "sudo", ofType: "deb") else {
            let msg = "Could not find sudo"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        guard let libplist3 = Bundle.main.path(forResource: "libplist3", ofType: "deb") else {
            let msg = "Could not find libplist3"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let libmagic1 = Bundle.main.path(forResource: "libmagic1_5.43_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find libmagic1"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let nano = Bundle.main.path(forResource: "nano_6.4_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find nano"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let bigbossicon = Bundle.main.path(forResource: "org.thebigboss.repo.icons_1.0", ofType: "deb") else {
            let msg = "Could not find bigbossicon"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let bzip2 = Bundle.main.path(forResource: "bzip2_1.0.8_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find bzip2"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let gnupg = Bundle.main.path(forResource: "gnupg_2.2.11-2_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find gnupg"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let gzip = Bundle.main.path(forResource: "gzip_1.11_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find gzip"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let lzma = Bundle.main.path(forResource: "lzma_4.32.7-5_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find lzma"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let aptlib = Bundle.main.path(forResource: "apt7-lib_0.7.25.3-16_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find aptlib"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let aptkey = Bundle.main.path(forResource: "apt7-key_0.7.25.3-3_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find aptkey"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let cydialproj = Bundle.main.path(forResource: "cydia-lproj_1.1.32_b1_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find cydialproj"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let xzutils = Bundle.main.path(forResource: "xz-utils_5.2.5-3_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find xzutils"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let sileosources = Bundle.main.path(forResource: "sileo", ofType: "sources") else {
            let msg = "Could not find sileosources"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let cydiaplist = Bundle.main.path(forResource: "com.saurik.Cydia", ofType: "plist") else {
            let msg = "Could not find cydiaplist"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let cydialist = Bundle.main.path(forResource: "cydia", ofType: "list") else {
            let msg = "Could not find cydialist"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let choicyprefs = Bundle.main.path(forResource: "com.opa334.choicyprefs", ofType: "plist") else {
            let msg = "Could not find choicyprefs"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let cydia = Bundle.main.path(forResource: "cydia_1.1.36_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find cydia"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let dismissprogress = Bundle.main.path(forResource: "org.thebigboss.dismissprogress_1.1.1_iphoneos-arm", ofType: "deb") else {
            let msg = "Could not find dismissprogress"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
		
        guard let bigbossaptkey = Bundle.main.path(forResource: "apt.thebigboss.org_iphoneos-arm", ofType: "asc") else {
            let msg = "Could not find bigbossaptkey"
            console.error("[-] \(msg)")
            tb.toolbarState = .closeApp
            print("[palera1n] \(msg)")
            return
        }
        
        DispatchQueue.global(qos: .utility).async { [self] in
            spawn(command: "/sbin/mount", args: ["-uw", "/private/preboot"], root: true)
            spawn(command: "/sbin/mount", args: ["-uw", "/"], root: true)
            
            let ret = spawn(command: helper, args: ["-i", tar], root: true)
            
            spawn(command: "/usr/bin/chmod", args: ["4755", "/usr/bin/sudo"], root: true)
            spawn(command: "/usr/bin/chown", args: ["root:wheel", "/usr/bin/sudo"], root: true)
            
            DispatchQueue.main.async {
                if ret != 0 {
                    console.error("[-] Error installing bootstrap. Status: \(ret)")
                    tb.toolbarState = .closeApp
                    return
                }
                
                console.log("[*] Preparing Bootstrap")
                DispatchQueue.global(qos: .utility).async {
                
                    // fix zsh killed 9: /usr/bin/rm
                    spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                    
                    spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", libplist3], root: true)
                    spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", ldid], root: true)

                    // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                    spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                    spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                    spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                    
                    spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                    spawn(command: "/usr/sbin/pwd_mkdb", args: ["-p", "/etc/master.passwd"], root: true)
                    spawn(command: "/Library/dpkg/info/debianutils.postinst", args: ["configure", "99999"], root: true)
                    spawn(command: "/Library/dpkg/info/apt.postinst", args: ["configure", "99999"], root: true)
                    spawn(command: "/Library/dpkg/info/dash.postinst", args: ["configure", "99999"], root: true)
                    spawn(command: "/Library/dpkg/info/zsh.postinst", args: ["configure", "99999"], root: true)
                    spawn(command: "/Library/dpkg/info/bash.postinst", args: ["configure", "99999"], root: true)
                    spawn(command: "/Library/dpkg/info/vi.postinst", args: ["configure", "99999"], root: true)
                    spawn(command: "/Library/dpkg/info/openssh-server.extrainst_", args: ["install"], root: true)
                    spawn(command: "/usr/sbin/pwd_mkdb", args: ["-p", "/etc/master.passwd"], root: true)
                    spawn(command: "/usr/bin/chsh", args: ["-s", "/usr/bin/zsh", "mobile"], root: true)
                    spawn(command: "/usr/bin/chsh", args: ["-s", "/usr/bin/zsh", "root"], root: true)
					
                    spawn(command: "/bin/mkdir", args: ["-p", "/tmp/palera1nLoader"], root: true)
					
                    spawn(command: "/bin/cp", args: [libmagic1, "/tmp/palera1nLoader/libmagic1_5.43_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [nano, "/tmp/palera1nLoader/nano_6.4_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [bigbossicon, "/tmp/palera1nLoader/org.thebigboss.repo.icons_1.0.deb"], root: true)
                    spawn(command: "/bin/cp", args: [bzip2, "/tmp/palera1nLoader/bzip2_1.0.8_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [gnupg, "/tmp/palera1nLoader/gnupg_2.2.11-2_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [gzip, "/tmp/palera1nLoader/gzip_1.11_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [lzma, "/tmp/palera1nLoader/lzma_4.32.7-5_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [aptlib, "/tmp/palera1nLoader/apt7-lib_0.7.25.3-16_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [aptkey, "/tmp/palera1nLoader/apt7-key_0.7.25.3-3_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [cydialproj, "/tmp/palera1nLoader/cydia-lproj_1.1.32_b1_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [xzutils, "/tmp/palera1nLoader/xz-utils_5.2.5-3_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [sileosources, "/tmp/palera1nLoader/sileo.sources"], root: true)
                    spawn(command: "/bin/cp", args: [cydiaplist, "/tmp/palera1nLoader/com.saurik.Cydia.plist"], root: true)
                    spawn(command: "/bin/cp", args: [cydialist, "/tmp/palera1nLoader/cydia.list"], root: true)
                    spawn(command: "/bin/cp", args: [choicyprefs, "/tmp/palera1nLoader/com.opa334.choicyprefs.plist"], root: true)
                    spawn(command: "/bin/cp", args: [cydia, "/tmp/palera1nLoader/cydia_1.1.36_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [dismissprogress, "/tmp/palera1nLoader/org.thebigboss.dismissprogress_1.1.1_iphoneos-arm.deb"], root: true)
                    spawn(command: "/bin/cp", args: [bigbossaptkey, "/tmp/palera1nLoader/apt.thebigboss.org_iphoneos-arm.asc"], root: true)
                    
                    spawn(command: "/usr/bin/sh", args: ["/cydia_install.sh"], root: true)
                    
                    // fix zsh killed 9: /usr/bin/rm
                    spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                    
                    spawn(command: helper, args: ["-i", tar], root: true)
                    
                    DispatchQueue.main.async {
                        
                        // fix zsh killed 9: /usr/bin/rm
                        spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                        
                        spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", libplist3], root: true)
                        spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", ldid], root: true)
                        spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", deb], root: true)

                        // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                        spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                        spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                        spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                        
                        spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                        spawn(command: "/usr/sbin/pwd_mkdb", args: ["-p", "/etc/master.passwd"], root: true)
                        spawn(command: "/Library/dpkg/info/debianutils.postinst", args: ["configure", "99999"], root: true)
                        spawn(command: "/Library/dpkg/info/apt.postinst", args: ["configure", "99999"], root: true)
                        spawn(command: "/Library/dpkg/info/dash.postinst", args: ["configure", "99999"], root: true)
                        spawn(command: "/Library/dpkg/info/zsh.postinst", args: ["configure", "99999"], root: true)
                        spawn(command: "/Library/dpkg/info/bash.postinst", args: ["configure", "99999"], root: true)
                        spawn(command: "/Library/dpkg/info/vi.postinst", args: ["configure", "99999"], root: true)
                        spawn(command: "/Library/dpkg/info/openssh-server.extrainst_", args: ["install"], root: true)
                        spawn(command: "/usr/sbin/pwd_mkdb", args: ["-p", "/etc/master.passwd"], root: true)
                        spawn(command: "/usr/bin/chsh", args: ["-s", "/usr/bin/zsh", "mobile"], root: true)
                        spawn(command: "/usr/bin/chsh", args: ["-s", "/usr/bin/zsh", "root"], root: true)
                        
                        let ret = spawn(command: "/usr/bin/sh", args: ["/prep_bootstrap.sh"], root: true)
                        DispatchQueue.main.async {
                            if ret != 0 {
                                console.error("[-] Failed to prepare bootstrap. Status: \(ret)")
                                tb.toolbarState = .closeApp
                                return
                            }
                            
                            console.log("[*] Installing packages")
                            DispatchQueue.global(qos: .utility).async {
                            
                                // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                                spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                                
                                spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", deb, zebra, libswift, safemode, preferenceloader, substitute], root: true)
                                
                                // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                                spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                                
                                spawn(command: "/usr/bin/apt", args: ["install", "-y", "file", "coreutils", "mawk", "ldid", "sed"], root: true)
                                
                                // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                                spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                                
                                // awk and sed need be resigned for auto sign to work
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/awk"], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/sed"], root: true)
                                
                                // install autosign
                                spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", autosign], root: true)
                                
                                // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                                spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                                
                                spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", libhooker], root: true)
                                
                                // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                                spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                                
                                spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", rocketbootstrap], root: true)
                                
                                // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                                spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                                
                                spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", cephei], root: true)
                                
                                // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                                spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                                
                                spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", altlist], root: true)
                                
                                // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                                spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                                
                                spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", choicy], root: true)
                                
                                // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                                spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                                
                                spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", sudo], root: true)
                                
                                // fix potentially broken apt, dpkg, firmware, cy+cpu.arm64 but it is not installable
                                spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                                spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/apt"], root: true)
                                
                                // fix ssh bash terminal on ios 16
                                spawn(command: "/usr/libexec/firmware", args: [""], root: true)
                                spawn(command: "/usr/sbin/pwd_mkdb", args: ["-p", "/etc/master.passwd"], root: true)
                                spawn(command: "/Library/dpkg/info/debianutils.postinst", args: ["configure", "99999"], root: true)
                                spawn(command: "/Library/dpkg/info/apt.postinst", args: ["configure", "99999"], root: true)
                                spawn(command: "/Library/dpkg/info/dash.postinst", args: ["configure", "99999"], root: true)
                                spawn(command: "/Library/dpkg/info/zsh.postinst", args: ["configure", "99999"], root: true)
                                spawn(command: "/Library/dpkg/info/bash.postinst", args: ["configure", "99999"], root: true)
                                spawn(command: "/Library/dpkg/info/vi.postinst", args: ["configure", "99999"], root: true)
                                spawn(command: "/Library/dpkg/info/openssh-server.extrainst_", args: ["install"], root: true)
                                spawn(command: "/usr/sbin/pwd_mkdb", args: ["-p", "/etc/master.passwd"], root: true)
                                spawn(command: "/usr/bin/chsh", args: ["-s", "/usr/bin/zsh", "mobile"], root: true)
                                spawn(command: "/usr/bin/chsh", args: ["-s", "/usr/bin/zsh", "root"], root: true)
                                spawn(command: "/usr/bin/sh", args: ["/launch_ssh_daemon.sh"], root: true)
                                
                                console.log("[*] Registering Zebra in uicache")
                                DispatchQueue.global(qos: .utility).async {
                                    spawn(command: "/usr/bin/uicache", args: ["-p", "/Applications/Cydia.app"], root: true)
                                    let ret = spawn(command: "/usr/bin/uicache", args: ["-p", "/Applications/Zebra.app"], root: true)
                                    DispatchQueue.main.async {
                                        if ret != 0 {
                                            console.error("[-] Failed to uicache. Status: \(ret)")
                                            tb.toolbarState = .closeApp
                                            return
                                        }
                                        console.log("[*] Finished installing! Enjoy!")
                                        
                                        tb.toolbarState = .respring
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

class ToolbarStateMoment: ObservableObject {
    static let s = ToolbarStateMoment()
    
    @Published var toolbarState: ToolbarController.ToolbarState = .toolbar
}

struct ToolbarController: View {
    var bs: () -> Void
    
    init(bootstrapAction: @escaping () -> Void) {
        self.bs = bootstrapAction
    }
    
    @State var settingsIsOpen = false
    @State var infoIsOpen = false
    
    @State var buttonBounds: CGSize? = nil
    
    @ObservedObject var state = ToolbarStateMoment.s
    
    public enum ToolbarState {
        case toolbar
        case disabled
        case closeApp
        case respring
    }
    
    var body: some View {
        VStack {
            switch state.toolbarState {
            case .toolbar:
                toolbar
            case .disabled:
                disabled
            case .closeApp:
                closeApp
            case .respring:
                respring
            }
        }
        .animation(.easeInOut, value: state.toolbarState)
    }
    
    @ViewBuilder
    var toolbar: some View {
        HStack {
            Button {
                self.settingsIsOpen.toggle()
            } label: {
                Image(systemName: "gearshape.circle.fill")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
            .sheet(isPresented: $settingsIsOpen) {
                SettingsSheetView(isOpen: $settingsIsOpen)
            }
            
            Button {
                self.bs()
            } label: {
                Text("Install")
                    .foregroundColor(.init(hex: "68431f"))
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .padding(8)
                    .background(Capsule().foregroundColor(.white))
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 10)
            
            Button {
                self.infoIsOpen.toggle()
            } label: {
                Image(systemName: "info.circle.fill")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
            .sheet(isPresented: $infoIsOpen) {
                CreditsSheetView(isOpen: $infoIsOpen)
            }
        }
        .padding()
        .background(
            Capsule()
                .foregroundColor(.init("CellBackground"))
        )
    }
    
    @ViewBuilder
    var disabled: some View {
        EmptyView()
    }
    
    @ViewBuilder
    var closeApp: some View {
        Button {
            fatalError()
        } label: {
            Text("Close")
                .font(.body)
                .foregroundLinearGradient(colors: [.init(hex: "071B33"), .init(hex: "833F46"), .init(hex: "FFB123")], startPoint: .leading, endPoint: .trailing)
                .frame(maxWidth: .infinity)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                }
        }
        .buttonStyle(.plain)
        .padding()
        .padding(.horizontal)
        .frame(maxHeight: 30)
    }
    
    @ViewBuilder
    var respring: some View {
        Button {
            utils.respring()
        } label: {
            Text("Respring")
                .font(.body)
                .foregroundLinearGradient(colors: [.init(hex: "071B33"), .init(hex: "833F46"), .init(hex: "FFB123")], startPoint: .leading, endPoint: .trailing)
                .frame(maxWidth: .infinity)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                }
        }
        .buttonStyle(.plain)
        .padding()
        .padding(.horizontal)
        .frame(maxHeight: 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
