func runSubscriptsExamples() {
    // ==================================================
    // SUBSCRIPT SYNTAX
    // ==================================================
    struct TimesTable {
        let multiplier: Int

        subscript(index: Int) -> Int {
            return multiplier * index // Creates multiplication table using subscript
        }
    }
    let threeTimesTable = TimesTable(multiplier: 3)
    print("3 x 6 = \(threeTimesTable[6])") // Using subscript

    // ==================================================
    // SUBSCRIPT USAGE
    // ==================================================
    struct Matrix {
        let rows: Int
        let columns: Int
        var grid: [Double]

        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            self.grid = Array(repeating: 0.0, count: rows * columns) // Creates matrix
        }

        func indexIsValid(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }

        subscript(row: Int, column: Int) -> Double {
            get {
                assert(indexIsValid(row: row, column: column), "Index out of range") // Validates range
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }

    var matrix = Matrix(rows: 2, columns: 2)
    matrix[0, 1] = 1.5 // Assigns value using subscript
    matrix[1, 0] = 3.2
    print("Matrix Value at (0, 1): \(matrix[0, 1])") // Reads value using subscript
    print("Matrix Value at (1, 0): \(matrix[1, 0])")

    // ==================================================
    // SUBSCRIPT OPTIONS
    // ==================================================
    struct Cuboid {
        var width = 0.0
        var height = 0.0
        var depth = 0.0

        subscript(dimension: String) -> Double? {
            switch dimension {
            case "width":
                return width
            case "height":
                return height
            case "depth":
                return depth
            default:
                return nil // Returns nil for invalid dimension query
            }
        }
    }
    let cuboid = Cuboid(width: 4.0, height: 5.0, depth: 6.0)
    print("Width: \(cuboid["width"] ?? 0.0)") // Valid dimension
    print("Invalid Dimension: \(cuboid["weight"] ?? 0.0)") // Invalid dimension

    // ==================================================
    // TYPE SUBSCRIPTS
    // ==================================================
    enum DaysOfWeek: Int {
        case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday

        static subscript(index: Int) -> DaysOfWeek? {
            return DaysOfWeek(rawValue: index) // Subscripting with raw value
        }
    }
    if let day = DaysOfWeek[3] { // Accessing enum value with subscript
        print("Day 3 is \(day).")
    } else {
        print("Invalid day index.")
    }
}

