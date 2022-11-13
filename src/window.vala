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

        public Window (Gtk.Application app) {
            Object (application: app);
        }

        [GtkCallback]
        private void on_operate_button_clicked ()
            requires (data_row.holds_data)
        {
            var builder = new ColumnBuilder () {
                use_title_row = title_check.active
            };
            builder.add_text (data_row.data);

            print_results (builder.build ());
        }

        private void print_results (ListModel model) {
            var calculator = new DataCalculator ();
            Results[] results = calculator.calculate (model);

            for (int i = 0; i < results.length; i++) {
                Results result = results[i];
                print ("%s\n", result.title);

                for (int j = 0; j < result.operation_results.get_n_items (); j++) {
                    var operation = (Operation) result.operation_results.get_item (j);
                    print ("%s = %f\n", operation.operation, operation.result);
                }

                print ("\n\n");
            }
        }
    }
}
