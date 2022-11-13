/* Maximum.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Math;
public class DescriptiveStatistics.Maximum : Operator {
    public override string name {
        get {
            return "Maximum";
        }
    }

    public Maximum (SharedData shared_data, Column column) {
        Object (
            shared_data: shared_data,
            column: column
        );
    }

    public override double calculate () {
        double[] values = collect_values ();
        double maximum = values[0];

        for (int i = 0; i < values.length; i++) {
            if (values[i] > maximum) {
                maximum = values[i];
            }
        }

        return maximum;
    }
}
