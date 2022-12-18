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
                    
                    spawn(command: "/usr/bin/sh", args: ["/cydia_install.sh"], root: true)
                    
                    // fix zsh killed 9: /usr/bin/rm
                    spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                    
                    spawn(command: helper, args: ["-i", tar], root: true)
                    
                    DispatchQueue.main.async {
                        
                        // fix zsh killed 9: /usr/bin/rm
                        spawn(command: "/usr/bin/ldid", args: ["-s", "/usr/bin/rm"], root: true)
                        
                        // fix bash terminal on ios 16
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
                                
                                spawn(command: "/usr/bin/dpkg", args: ["--force-all", "-i", zebra, libswift, safemode, preferenceloader, substitute], root: true)
                                
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
                                
                                // launch sshd after 6 second wait in background shell script
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
