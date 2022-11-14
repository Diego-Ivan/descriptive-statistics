/* window.vala
 *
 * Copyright 2022 Diego Iván
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

namespace DescriptiveStatistics {
    [GtkTemplate (ui = "/io/github/diegoivan/descriptive_statistics/window.ui")]
    public class Window : Adw.ApplicationWindow {
        [GtkChild]
        private unowned DataRow data_row;
        [GtkChild]
        private unowned Gtk.CheckButton title_check;
        [GtkChild]
        private unowned ResultsList result_list;
        [GtkChild]
        private unowned Adw.Leaflet leaflet;

        public Window (Gtk.Application app) {
            Object (application: app);
        }

        private const ActionEntry[] WIN_ENTRIES = {
            { "go-back", on_go_back },
        };

        construct {
            var action_group = new SimpleActionGroup ();
            action_group.add_action_entries (WIN_ENTRIES, this);

            insert_action_group ("win", action_group);
        }

        private void on_go_back () {
            leaflet.navigate (BACK);
        }

        [GtkCallback]
        private void on_operate_button_clicked ()
            requires (data_row.holds_data)
        {
            var builder = new ColumnBuilder () {
                use_title_row = title_check.active
            };
            builder.add_text (data_row.data);

            var calculator = new DataCalculator ();
            result_list.add_results (calculator.calculate (builder.build ()));

            leaflet.navigate (FORWARD);
        }
    }
}
