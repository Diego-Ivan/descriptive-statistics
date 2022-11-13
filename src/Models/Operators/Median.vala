/* Median.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Math;
public class DescriptiveStatistics.Median : Operator {
    public override string name {
        get {
            return "Median";
        }
    }

    public Median (SharedData shared_data, Column column) {
        Object (
            shared_data: shared_data,
            column: column
        );
    }

    public override double calculate () {
        double[] values = collect_values ();
        if ((values.length % 2) != 0) {
            return values [(values.length - 1) / 2];
        }
        double val1 = values[(values.length / 2) - 1];
        double val2 = values[(values.length / 2) + 1];

        return (val1 + val2) / 2;
    }
}
