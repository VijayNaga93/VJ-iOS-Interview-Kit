//
//  OnDemandCheckView.swift
//  ReduceAppSize
//
//  Created by Vijay N on 26/03/25.
//

import SwiftUI


class OnDemandCheckViewModel: ObservableObject {
    //    @Published var weapons: [Weapon] = []
    var weapons: [Weapon] = [
        
        Weapon(name: "Stygian_Blade", resourceTag: "Level1"),
        Weapon(name: "Eternal_Spear", resourceTag: "Level2"),
        Weapon(name: "Shield_of_Chaos", resourceTag: "Level3"),
        Weapon(name: "Seeker_Bow", resourceTag: "Level4"),
        Weapon(name: "Twin_Fists", resourceTag: "Level5"),
        Weapon(name: "Adamant_Rail", resourceTag: "Level6")
        
    ]
    
    //    func fetchWeapons() {
    //        let w1 = Weapon(name: "Stygian_Blade", image: nil)
    //        let w2 = Weapon(name: "Eternal_Spear", image: nil)
    //        let w3 = Weapon(name: "Shield_of_Chaos", image: nil)
    //        let w4 = Weapon(name: "Seeker_Bow", image: nil)
    //        let w5 = Weapon(name: "Twin_Fists", image: nil)
    //        let w6 = Weapon(name: "Adamant_Rail", image: nil)
    //
    //        weapons = [ w1, w2, w3, w4, w5, w6 ]
    //    }
    
    
    /*
     Stygian_Blade
     Eternal_Spear
     Shield_of_Chaos
     Heart-Seeker_Bow
     Twin_Fists
     Adamant_Rail
     */
    
    
}

struct OnDemandCheckView: View {
    var viewModel = OnDemandCheckViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    let rows = [GridItem(.fixed(150))]
    
    
    //    var body: some View {
    //        VStack {
    //            Text("Hello, World!")
    //            gridstack
    //
    //        }
    //        .navigationTitle("OnDemand Checker")
    //        .onAppear {
    //            viewModel.fetchWeapons()
    //        }
    //
    //    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                
                //        ScrollView(.horizontal) {
                //            LazyHGrid(rows: rows, spacing: 20) {
                
                
                ForEach(viewModel.weapons) { weapon in
                    
                    //                    WeaponGallery(weapon: weapon, weaponRequest: nil)
                    WeaponGallery(viewModel: WeaponGalleryViewModel(weapon: weapon))
                }
            }
            .padding()
        }
        .background(.gray)
    }
}

#Preview {
    OnDemandCheckView()
}

struct Weapon: Identifiable {
    var id = UUID()
    var name: String
    var resourceTag: String
}

enum WeaponStatus {
    case available
    case notAvailable
    case reload
    case failed
}


class WeaponGalleryViewModel : ObservableObject {
    var weapon : Weapon
    var weaponRequest: NSBundleResourceRequest?
    @Published var weaponStatus: WeaponStatus = .available
    
    init(weapon: Weapon) {
        self.weapon = weapon
        self.checkResource()
    }
    func checkResource() {
        weaponRequest = NSBundleResourceRequest(tags: [weapon.resourceTag])
        
        
        weaponRequest?.conditionallyBeginAccessingResources { isDownloaded in
            DispatchQueue.main.async {
                if isDownloaded {
                    print("Downloaded already")
                    self.weaponStatus = .available
                    
                } else {
                    self.weaponStatus = .notAvailable
                    print("NotDownloaded")
                }
            }
        }
    }
    
    func downloadResource() {
        weaponRequest?.beginAccessingResources { error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Download Failed")
                    self.weaponStatus = .failed
                    return
                }
                self.weaponStatus = .reload
                print("Download Success")
            }
        }
        
    }
    
    
}

struct WeaponGallery: View {
    @ObservedObject var viewModel: WeaponGalleryViewModel
    
    var body: some View {
        VStack {
            
            ZStack {
                switch viewModel.weaponStatus {
                case .available:
                    Image(viewModel.weapon.name)
                        .resizable()
                        .frame(width: 50, height: 100)
                        .foregroundColor(.blue)
                case .notAvailable:
                    Button("", systemImage: "square.and.arrow.down") {
                        //                        checkResource()
                        viewModel.downloadResource()
                    }
                    
                case .reload:
                    Image(viewModel.weapon.name)
                        .resizable()
                        .frame(width: 50, height: 100)
                        .foregroundColor(.green)
                case .failed:
                    Text("Asset Download failed...")
                }
                
                
            }
            
            Text(viewModel.weapon.name)
                .font(.headline)
                .frame(width: 500, height: 100)
                .foregroundColor(.blue)
            
        }
        .frame(width: 150, height: 180)
        .background(Color.orange.opacity(0.2))
        .cornerRadius(10)
        
        
    }
    
    
    
    
    //    func checkResource() {
    //        print("weapon.resourceTag-->\(weapon.resourceTag)")
    //        let weaponRequest = NSBundleResourceRequest(tags: [weapon.resourceTag])
    //
    //        weaponRequest.conditionallyBeginAccessingResources { isDownloaded in
    //            if isDownloaded {
    //                print("Downloaded already")
    //                weaponStatus = .available
    //            } else {
    //                print("NotDownloaded")
    //
    //                weaponRequest.beginAccessingResources { error in
    //                    guard error == nil else {
    //                        print("Download Failed")
    //                        weaponStatus = .notAvailable
    //                        return
    //                    }
    //                    weaponStatus = .reload
    //                    print("Download Success")
    //                }
    //            }
    //        }
    //    }
    
    
    //        func checkResource() {
    //
    //            let weaponRequest = NSBundleResourceRequest(tags: [weapon.resourceTag])
    //
    //            weaponRequest.conditionallyBeginAccessingResources { isDownloaded in
    //                if isDownloaded {
    //                    print("Downloaded already")
    //                    weaponStatus = .available
    //                } else {
    //                    weaponStatus = .notAvailable
    //                    print("NotDownloaded")
    //
    //                    weaponRequest.beginAccessingResources { error in
    //                        guard error == nil else {
    //                            print("Download Failed")
    //
    //                            return
    //                        }
    //                        weaponStatus = .reload
    //                        print("Download Success")
    //                    }
    //                }
    //            }
    //        }
    
    
    
    //    func downloadResource() {
    //        print("weapon.resourceTag-->\(weapon.resourceTag)")
    //        let weaponRequest = NSBundleResourceRequest(tags: [weapon.resourceTag])
    //
    //        weaponRequest.conditionallyBeginAccessingResources { isDownloaded in
    //            if isDownloaded {
    //                print("Downloaded already")
    //                weaponStatus = .available
    //            } else {
    //                print("NotDownloaded")
    //
    //                weaponRequest.beginAccessingResources { error in
    //                    guard error == nil else {
    //                        print("Download Failed")
    //                        weaponStatus = .notAvailable
    //                        return
    //                    }
    //                    weaponStatus = .reload
    //                    print("Download Success")
    //                }
    //            }
    //        }
    //    }
    
    
}



class UrlsessionCheckViewModel {
    func check1() {
        URLSession.shared.dataTask(with: URLRequest)
        URLSession.dataTask(URLSession)
    }
}
