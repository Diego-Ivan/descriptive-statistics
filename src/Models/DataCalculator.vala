/* DataCalculator.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
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

public class DescriptiveStatistics.DataCalculator : Object {
    public DataCalculator () {}

    public Results[] calculate (ListModel model)
        requires (model.get_item_type () == typeof(Column))
    {
        Results[] results = {};

        for (int i = 0; i < model.get_n_items (); i++) {
            var item = (Column) model.get_item (i);
            tidy_column (item);
            if (item.get_n_items () <= 1)
                continue;

            results += operate_column (item);
        }

        return results;
    }

    private void tidy_column (Column column) {
        var result = new Column () {
            has_title_row = column.has_title_row
        };

        // In the upcoming loop, skip the first row for verification
        // in case it is a title row
        int i = result.has_title_row ? 1 : 0;

        Row? item;
        while ((item = (Row) column.get_item (i)) != null) {
            if (!item.is_number) {
                column.remove_item (i);
                continue;
            }
            i++;
        }
    }

    private Results operate_column (Column column)
        requires (column.get_n_items () > 1)
    {
        var model = new ListStore (typeof(Operation));
        var shared_data = new SharedData ();

        if (column.has_title_row) {
            // Set title in the shared data
            var title_row = (Row) column.get_item (0);
            shared_data.title = title_row.content;

            // Set item count
            shared_data.count = column.get_n_items () - 1;
        }
        else {
            shared_data.count = column.get_n_items ();
        }

        Operator[] operators = {
            new Sum (shared_data, column),
            new Mean (shared_data, column),

            new SampleVariance (shared_data, column),
            new StandardDeviation (shared_data, column),
            new StandardError (shared_data, column),

            new Kurtosis (shared_data, column),
            new Skewness (shared_data, column),

            new Median (shared_data, column),
            new Maximum (shared_data, column),
            new Minimum (shared_data, column),
            new Mode (shared_data, column),
        };

        foreach (var operator in operators) {
            var op = new Operation () {
                result = operator.calculate (),
                operation = operator.name
            };

            model.append (op);
        }

        return new Results (shared_data.title, model);
    }
}

[Compact (opaque = true)]
public class DescriptiveStatistics.SharedData {
    public string title { get; set; default = ""; }
    public double count { get; set; default = 0; }

    public double sum { get; set; default = 0; }
    public double mean { get; set; default = 0; }
    public double variance { get; set; default = 0; }
    public double std_dev { get; set; default = 0; }
}

public class DescriptiveStatistics.Operation : Object {
    public string operation { get; set; default = ""; }
    public double result { get; set; default = 0; }
}

public class DescriptiveStatistics.Results {
    public string title { get; set; default = ""; }
    public ListModel operation_results { get; set; }

    public Results (string title, ListModel results)
        requires (results.get_item_type () == typeof(Operation))
    {
        this.title = title;
        this.operation_results = results;
    }
}
