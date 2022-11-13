/* Mode.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Math;
public class DescriptiveStatistics.Mode : Operator {
    public override string name {
        get {
            return "Mode";
        }
    }

    public Mode (SharedData shared_data, Column column) {
        Object (
            shared_data: shared_data,
            column: column
        );
    }

    public override double calculate () {
        var map = new Gee.HashMap<double?, int?> (null, (a, b) =>{ return a == b; });
        double[] values = collect_values ();

        foreach (double val in values) {
            if (!map.has_key (val)) {
                map.set (val, 1);
                continue;
            }
            int count = map.get (val);
            map.unset (val);
            map.set (val, count+1);
        }

        double mode = 0;
        int mode_counter = 0;

        map.foreach ((entry) => {
            if (entry.value > mode_counter) {
                mode = entry.key;
                mode_counter = entry.value;
            }
            return true;
        });

        return mode;
    }
}
