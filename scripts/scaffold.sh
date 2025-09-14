#!/usr/bin/env zsh
set -euo pipefail

echo "→ Creating folders…"
mkdir -p Core/{Models,Persistence/Repositories,Services,Theme} \
         Features/{Home,Nutrition,Pumping,Diapers,Hydration,Calendars,Onboarding,Profile} \
         UI/{Components,AppShell} \
         Resources DataModel

mkfile_if_missing() {
  local path="$1"; shift
  if [[ -f "$path" ]]; then
    echo "• exists  $path"
  else
    echo "• create  $path"
    cat > "$path" <<EOF
$@
EOF
  fi
}

touch_if_missing() {
  local path="$1"
  if [[ -f "$path" ]]; then
    echo "• exists  $path"
  else
    echo "• touch   $path"
    : > "$path"
  fi
}

echo "→ Seed minimal compile-safe stubs (Copilot will flesh these out)…"

# App shell
mkfile_if_missing UI/AppShell/RootTabView.swift 'import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house.fill") }
            DualFeedTimerView().tabItem { Label("Pump", systemImage: "clock.fill") }
            DiaperLogView().tabItem { Label("Diapers", systemImage: "drop.fill") }
            MonthCalendarView().tabItem { Label("Calendar", systemImage: "calendar") }
            ProfileView().tabItem { Label("Profile", systemImage: "person.fill") }
        }
    }
}

# Placeholder screens so it builds; Copilot will replace these with real ones.
struct ProfileView: View { var body: some View { Text("Profile") } }
'

# Theme (references to named colors you’ll add in Assets: Sage, Cream, TextPrimary, Accent)
mkfile_if_missing Core/Theme/LatchTheme.swift 'import SwiftUI

enum LatchTheme {
    static let sage       = Color("Sage")
    static let cream      = Color("Cream")
    static let text       = Color("TextPrimary")
    static let accent     = Color("Accent")
}
'

# Components
mkfile_if_missing UI/Components/MacroRingView.swift 'import SwiftUI

/// Minimal ring; ask Copilot to enhance (MyFitnessPal style)
struct MacroRingView: View {
    var progress: Double
    var centerTop: String
    var centerBottom: String

    var body: some View {
        ZStack {
            Circle().stroke(lineWidth: 16).foregroundStyle(Color("Sage").opacity(0.22))
            Circle().trim(from: 0, to: max(0,min(1,progress)))
                .stroke(Color("Sage"), style: StrokeStyle(lineWidth: 16, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.4), value: progress)
            VStack(spacing: 4){
                Text(centerTop).font(.title3).fontWeight(.semibold).foregroundStyle(Color("TextPrimary"))
                Text(centerBottom).font(.caption).foregroundStyle(.secondary)
            }
        }
    }
}
'

# Home
mkfile_if_missing Features/Home/HomeView.swift 'import SwiftUI

/// Home screen — use Copilot to add calorie ring, quick actions, snapshots
struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                MacroRingView(progress: 0.3, centerTop: "1700 left", centerBottom: "of 2300 kcal")
                    .frame(width: 220, height: 220)
                Text("Home (stub)").foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
            .navigationTitle("LatchFitness")
        }
        .background(Color("Cream").ignoresSafeArea())
    }
}
'

# Pumping
mkfile_if_missing Features/Pumping/DualFeedTimerViewModel.swift 'import Foundation
import Combine

enum Side { case left, right }

final class DualFeedTimerViewModel: ObservableObject {
    @Published var leftElapsed: TimeInterval = 0
    @Published var rightElapsed: TimeInterval = 0
    @Published var isLeftRunning = false
    @Published var isRightRunning = false
}
'

mkfile_if_missing Features/Pumping/DualFeedTimerView.swift 'import SwiftUI

/// Dual side timers (Left/Right). Ask Copilot to add Start/Pause/End + mm:ss.
struct DualFeedTimerView: View {
    var body: some View {
        HStack(spacing: 16) {
            TimerCard(title: "Left")
            TimerCard(title: "Right")
        }
        .padding()
        .background(Color("Cream").ignoresSafeArea())
    }
}

private struct TimerCard: View {
    let title: String
    var body: some View {
        VStack(spacing: 12) {
            Text(title).font(.headline)
            Text("00:00").font(.system(size: 42, weight: .semibold, design: .rounded))
            Text("Timer (stub)").foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 18).fill(.white))
        .shadow(color: .black.opacity(0.06), radius: 10, y: 6)
    }
}
'

# Diapers
mkfile_if_missing Features/Diapers/DiaperLogView.swift 'import SwiftUI

/// Quick-add wet/dirty/both; Copilot will wire state + calendar later.
struct DiaperLogView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Diaper Tracker").font(.title2).bold()
            HStack {
                Button("Wet") {}
                Button("Dirty") {}
                Button("Both") {}
            }
            Text("Today: 0 wet • 0 dirty").foregroundStyle(.secondary)
            Spacer()
        }
        .padding()
        .background(Color("Cream").ignoresSafeArea())
    }
}
'

mkfile_if_missing Features/Diapers/DiaperStatsView.swift 'import SwiftUI

struct DiaperStatsView: View {
    var body: some View {
        Text("History (calendar + high score) — stub")
            .foregroundStyle(.secondary)
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 14).fill(.white))
            .padding(.horizontal)
    }
}
'

# Calendars
mkfile_if_missing Features/Calendars/MonthCalendarView.swift 'import SwiftUI

struct MonthCalendarView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Calendar").font(.title3).bold()
            Rectangle().fill(.white).frame(height: 240).cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
        }
        .padding()
        .background(Color("Cream").ignoresSafeArea())
    }
}
'

# Nutrition placeholders
touch_if_missing Features/Nutrition/LogView.swift
touch_if_missing Features/Nutrition/FoodSearchView.swift
touch_if_missing Features/Nutrition/SavedMealsView.swift
mkfile_if_missing Features/Nutrition/NutritionEngine.swift 'struct NutritionEngine {
    var targetKcal: Double
    var consumedKcal: Double
    var caloriesLeft: Double { max(0, targetKcal - consumedKcal) }
    var progress: Double { min(1, consumedKcal / max(1, targetKcal)) }
}'

# Hydration placeholders
touch_if_missing Features/Hydration/HydrationView.swift
touch_if_missing Features/Hydration/HydrationViewModel.swift

# Onboarding placeholders
touch_if_missing Features/Onboarding/WelcomeView.swift
touch_if_missing Features/Onboarding/GoalsSetupView.swift
touch_if_missing Features/Onboarding/LactationOffsetView.swift
touch_if_missing Features/Onboarding/OnboardingViewModel.swift

# Profile placeholders
touch_if_missing Features/Profile/ProfileView.swift
touch_if_missing Features/Profile/SettingsView.swift

echo "→ Done. Now open these files in Xcode and prompt Copilot at the top with a one-liner to flesh them out."
