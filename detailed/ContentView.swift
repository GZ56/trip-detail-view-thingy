import SwiftUI

struct Trip: Identifiable {
    var id = UUID()
    var name: String
    var destination: String
    var hotelAddress: String
    var attractionAddress: String
}

struct ContentView: View {
    @State private var upcomingTrips = [
        Trip(name: "Trip to Italy", destination: "Italy", hotelAddress: "123 Main St, Rome", attractionAddress: "456 Tourist Ave, Rome"),
        Trip(name: "Business Trip", destination: "New York", hotelAddress: "789 Business Blvd, NYC", attractionAddress: "101 Central St, NYC")
    ]

    @State private var pastTrips = [
        Trip(name: "Vacation in Paris", destination: "France", hotelAddress: "321 Vacation Lane, Paris", attractionAddress: "654 Sightseeing Blvd, Paris"),
        Trip(name: "Family Trip", destination: "London", hotelAddress: "987 Family Road, London", attractionAddress: "210 Museum Way, London")
    ]

    @State private var selectedTrip: Trip?

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                        .onTapGesture {
                           
                        }
                        .padding(.trailing, 20) // Adjust the trailing padding
                }
                .padding(.top, 20) // Add padding to the top

                TripCategoryView(trips: $upcomingTrips, category: "Upcoming Trips", selectedTrip: $selectedTrip)
                TripCategoryView(trips: $pastTrips, category: "Past Trips", selectedTrip: $selectedTrip)
            }
            .navigationBarTitle("Itineraries")
        }
        .sheet(item: $selectedTrip) { trip in
            DetailedTripView(trip: trip)
        }
    }
}

struct TripCategoryView: View {
    @Binding var trips: [Trip]
    var category: String
    @Binding var selectedTrip: Trip?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "plus.circle")
                    .font(.title)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        // Add a new trip
                        self.trips.append(Trip(name: "New Trip", destination: "Untitled Destination", hotelAddress: "Hotel Address", attractionAddress: "Attraction Address"))
                    }
            }
            .padding(.horizontal, 20) // Adjust the horizontal padding

            ScrollView {
                VStack {
                    ForEach(trips) { trip in
                        TripRowView(trip: trip, onTap: {
                            self.selectedTrip = trip
                        })
                        .padding(.bottom, 15)
                    }
                }
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            .padding(.horizontal, 20) // Adjust the horizontal padding
        }
        .padding(.vertical, 20) // Adjust the vertical padding
    }
}

struct TripRowView: View {
    var trip: Trip
    var onTap: () -> Void

    var body: some View {
        HStack {
            Text(trip.name)
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
            Image(systemName: "chevron.right.circle")
                .font(.title)
                .foregroundColor(.blue)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(15)
        .onTapGesture {
            self.onTap()
        }
    }
}

struct DetailedTripView: View {
    var trip: Trip

    var body: some View {
        VStack {
            Image(systemName: "airplane")
                .font(.system(size: 40)) // Adjust the icon size
                .foregroundColor(.blue)
                .padding()

            Text("Flight to \(trip.destination)")
                .font(.headline)
                .fontWeight(.bold)
                .padding()

            LocationDetailView(icon: "car", title: "Hotel", address: trip.hotelAddress)
            LocationDetailView(icon: "car", title: "Attraction", address: trip.attractionAddress)
        }
        .navigationBarTitle(trip.name)
    }
}

struct LocationDetailView: View {
    var icon: String
    var title: String
    var address: String

    var body: some View {
        HStack(alignment: .top) { // Align items to the top
            Image(systemName: icon)
                .font(.system(size: 30)) // Adjust the icon size
                .foregroundColor(.blue)
                .padding()

            VStack(alignment: .leading) { // Align items to the leading edge
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()

                Text(address)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()

                // Add a humorous address
                Text("Humorous Address: \(Int.random(in: 1...999)) Silly Lane, Chuckle City")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
